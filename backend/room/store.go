package room

import (
	"cmp"
	"errors"
	"slices"
	"sync"
	"time"
)

var errIDGenExhausted = errors.New("room: exhausted id generation attempts")

type storeErr int

const (
	storeErrNone storeErr = iota
	storeErrNotFound
	storeErrAlreadyInOtherRoom
	storeErrIDGenFailed
	storeErrNotInRoom
	storeErrAlreadyStarted
	storeErrNotReady
	storeErrStaleSession
	storeErrRoomFull
	storeErrNoActiveQuestion
	storeErrAlreadyAnswered
	storeErrBadOption
	storeErrAlreadyConnected
)

func storeErrToCode(sErr storeErr) int {
	switch sErr {
	case storeErrNotFound:
		return 19
	case storeErrAlreadyInOtherRoom:
		return 20
	case storeErrAlreadyConnected:
		return 21
	case storeErrIDGenFailed:
		return 22
	case storeErrAlreadyStarted:
		return 33
	case storeErrRoomFull:
		return 36
	case storeErrNoActiveQuestion:
		return 37
	case storeErrAlreadyAnswered:
		return 38
	case storeErrBadOption:
		return 39
	case storeErrNotInRoom:
		return 19
	default:
		return 0
	}
}

const sendBufferSize = 4 * maxPlayersPerRoom

var (
	mu       sync.RWMutex
	rooms    = make(map[string]*Room)
	userRoom = make(map[string]string)
)

func exists(id string) bool {
	mu.RLock()
	defer mu.RUnlock()

	_, ok := rooms[id]
	return ok
}

func passwordHash(id string) (hash string, found bool) {
	mu.RLock()
	defer mu.RUnlock()

	r, ok := rooms[id]
	if !ok {
		return "", false
	}
	return r.PasswordHash, true
}

func listRooms() []RoomListView {
	mu.RLock()
	list := make([]RoomListView, 0, len(rooms))
	for _, r := range rooms {
		// A room whose creator has not finished the handshake yet has a seat
		// but nobody behind it. Showing it in the lobby advertises a room with
		// a user count that nobody is actually sitting at.
		if !r.hasConnectedMember() {
			continue
		}
		list = append(list, r.listView())
	}
	mu.RUnlock()

	slices.SortFunc(list, func(a, b RoomListView) int {
		if c := cmp.Compare(b.CreatedAt, a.CreatedAt); c != 0 {
			return c
		}
		return cmp.Compare(a.ID, b.ID)
	})

	return list
}

func createRoom(name, creatorUsername, pwHash string, categoryIDs []int, lang string) (RoomView, storeErr) {
	mu.Lock()
	defer mu.Unlock()

	if _, ok := userRoom[creatorUsername]; ok {
		return RoomView{}, storeErrAlreadyInOtherRoom
	}

	id, err := uniqueRoomIDLocked()
	if err != nil {
		return RoomView{}, storeErrIDGenFailed
	}

	r := &Room{
		ID:           id,
		Name:         name,
		Members:      []*member{{username: creatorUsername}},
		CategoryIDs:  categoryIDs,
		PasswordHash: pwHash,
		Creator:      creatorUsername,
		Lang:         lang,
		CreatedAt:    time.Now().Unix(),
	}
	rooms[id] = r
	userRoom[creatorUsername] = id

	return r.view(), storeErrNone
}

func checkJoinable(roomID, username string) storeErr {
	mu.RLock()
	defer mu.RUnlock()

	r, ok := rooms[roomID]
	if !ok {
		return storeErrNotFound
	}
	// An account gets one socket at a time. Being seated anywhere at all is
	// enough to refuse: in another room the answer is "you are already in a
	// room", in this one it is "you already have this room open". Neither
	// case touches the live connection, so a second tab can never take the
	// first one down.
	if current, inRoom := userRoom[username]; inRoom {
		if current != roomID {
			return storeErrAlreadyInOtherRoom
		}
		return storeErrAlreadyConnected
	}

	if r.Started {
		return storeErrAlreadyStarted
	}
	if r.isFull() {
		return storeErrRoomFull
	}
	return storeErrNone
}

func attach(roomID, username string) (*member, RoomView, storeErr) {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[roomID]
	if !ok {
		return nil, RoomView{}, storeErrNotFound
	}

	if current, inRoom := userRoom[username]; inRoom && current != roomID {
		return nil, RoomView{}, storeErrAlreadyInOtherRoom
	}

	m := &member{username: username, send: make(chan []byte, sendBufferSize)}

	// checkJoinable already refused a seated account, but it runs under a read
	// lock before the upgrade, so several handshakes can pass it at once. This
	// is where the decision is actually made.
	if existing := r.indexOf(username); existing >= 0 {
		if !r.Members[existing].awaitingConnection() {
			return nil, RoomView{}, storeErrAlreadyConnected
		}
		r.Members[existing] = m
		return m, r.view(), storeErrNone
	}

	if r.Started {
		return nil, RoomView{}, storeErrAlreadyStarted
	}
	if r.isFull() {
		return nil, RoomView{}, storeErrRoomFull
	}

	r.Members = append(r.Members, m)
	userRoom[username] = roomID

	return m, r.view(), storeErrNone
}

func detach(username string, m *member) (roomID string, view RoomView, ok bool) {
	mu.Lock()
	defer mu.Unlock()

	defer m.closeSend()

	id, inRoom := userRoom[username]
	if !inRoom {
		return "", RoomView{}, false
	}

	r, roomOK := rooms[id]
	if !roomOK {
		delete(userRoom, username)
		return "", RoomView{}, false
	}

	idx := r.indexOf(username)
	if idx < 0 || r.Members[idx] != m {
		return "", RoomView{}, false
	}

	r.Members = append(r.Members[:idx], r.Members[idx+1:]...)
	delete(userRoom, username)

	maybeCloseAllDoneLocked(r)

	if len(r.Members) == 0 {
		delete(rooms, id)
		return "", RoomView{}, false
	}

	return id, r.view(), true
}

func leaveRoom(username string) {
	mu.Lock()
	defer mu.Unlock()

	id, ok := userRoom[username]
	if !ok {
		return
	}
	delete(userRoom, username)

	r, roomOK := rooms[id]
	if !roomOK {
		return
	}

	if idx := r.indexOf(username); idx >= 0 {
		r.Members[idx].closeSend()
		r.Members = append(r.Members[:idx], r.Members[idx+1:]...)
	}

	if len(r.Members) == 0 {
		delete(rooms, id)
	}
}

// reservationGrace is how long createRoom's seat may sit without a socket
// before it is swept. A handshake that is going to arrive arrives in
// milliseconds, so anything still empty after this never connected at all.
const reservationGrace = 10 * time.Second

// releaseUnconnectedSeat undoes the seat createRoom reserved when the
// WebSocket never showed up. It only ever touches a seat that has no socket,
// so a creator who did connect — and anyone who joined meanwhile — is left
// alone. The room goes with the seat when nobody else is left in it.
func releaseUnconnectedSeat(username, roomID string) (id string, view RoomView, ok bool) {
	mu.Lock()
	defer mu.Unlock()

	r, roomOK := rooms[roomID]
	if !roomOK {
		return "", RoomView{}, false
	}

	idx := r.indexOf(username)
	if idx < 0 || !r.Members[idx].awaitingConnection() {
		return "", RoomView{}, false
	}

	r.Members = append(r.Members[:idx], r.Members[idx+1:]...)
	if current, inRoom := userRoom[username]; inRoom && current == roomID {
		delete(userRoom, username)
	}

	if len(r.Members) == 0 {
		delete(rooms, roomID)
		return "", RoomView{}, false
	}

	return roomID, r.view(), true
}

func setReady(roomID string, m *member, ready bool) (view RoomView, allReady bool, sErr storeErr) {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[roomID]
	if !ok {
		return RoomView{}, false, storeErrNotFound
	}

	idx := r.indexOf(m.username)
	if idx < 0 {
		return RoomView{}, false, storeErrNotInRoom
	}
	if r.Members[idx] != m {
		return RoomView{}, false, storeErrStaleSession
	}

	if r.Started {
		return RoomView{}, false, storeErrAlreadyStarted
	}

	r.Members[idx].ready = ready

	return r.view(), r.allReady(), storeErrNone
}

func isCurrentSession(roomID string, m *member) bool {
	mu.RLock()
	defer mu.RUnlock()

	r, ok := rooms[roomID]
	if !ok {
		return false
	}
	idx := r.indexOf(m.username)
	return idx >= 0 && r.Members[idx] == m
}

func claimGameStart(roomID string) (categoryIDs []int, lang string, sErr storeErr) {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[roomID]
	if !ok {
		return nil, "", storeErrNotFound
	}
	if r.Started {
		return nil, "", storeErrAlreadyStarted
	}
	if !r.allReady() {
		return nil, "", storeErrNotReady
	}

	ids := make([]int, len(r.CategoryIDs))
	copy(ids, r.CategoryIDs)
	r.Started = true

	return ids, r.Lang, storeErrNone
}

func abortGameStart(roomID string) {
	mu.Lock()
	defer mu.Unlock()

	if r, ok := rooms[roomID]; ok {
		r.Started = false
	}
}

func startGame(roomID string, ids []int) storeErr {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[roomID]
	if !ok {
		return storeErrNotFound
	}

	order := make([]int, len(ids))
	copy(order, ids)
	r.QuestionIDs = order

	scores := make(map[string]int, len(r.Members))
	for _, m := range r.Members {
		scores[m.username] = 0
	}

	r.game = &gameState{scores: scores, index: -1}

	return storeErrNone
}

func startQuestion(roomID string, index, questionID int, correctOption string) (<-chan struct{}, storeErr) {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[roomID]
	if !ok {
		return nil, storeErrNotFound
	}
	if r.game == nil {
		return nil, storeErrNoActiveQuestion
	}

	g := r.game
	g.index = index
	g.questionID = questionID
	g.correctOption = correctOption
	g.startedAt = time.Now()
	g.answers = make(map[string]answerRecord, len(r.Members))
	g.allDone = make(chan struct{})
	g.doneClosed = false

	maybeCloseAllDoneLocked(r)

	return g.allDone, storeErrNone
}

func maybeCloseAllDoneLocked(r *Room) {
	g := r.game
	if g == nil || g.index < 0 || g.doneClosed || g.allDone == nil {
		return
	}

	for _, m := range r.Members {
		if _, answered := g.answers[m.username]; !answered {
			return
		}
	}

	g.doneClosed = true
	close(g.allDone)
}

func recordAnswer(roomID string, m *member, index int, option string) (answered, total int, sErr storeErr) {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[roomID]
	if !ok {
		return 0, 0, storeErrNotFound
	}

	idx := r.indexOf(m.username)
	if idx < 0 {
		return 0, 0, storeErrNotInRoom
	}
	if r.Members[idx] != m {
		return 0, 0, storeErrStaleSession
	}

	if !isValidOption(option) {
		return 0, 0, storeErrBadOption
	}

	g := r.game
	if g == nil || g.index < 0 || g.index != index {
		return 0, 0, storeErrNoActiveQuestion
	}
	if _, already := g.answers[m.username]; already {
		return 0, 0, storeErrAlreadyAnswered
	}

	elapsed := time.Since(g.startedAt)
	correct := option == g.correctOption

	points := 0
	if correct {
		points = scoreFor(elapsed)
	}

	g.answers[m.username] = answerRecord{
		option:  option,
		correct: correct,
		points:  points,
		elapsed: elapsed,
	}

	maybeCloseAllDoneLocked(r)

	return len(g.answers), len(r.Members), storeErrNone
}

func finishQuestion(roomID string, index int) (correctOption string, results []QuestionResult, board []ScoreEntry, sErr storeErr) {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[roomID]
	if !ok {
		return "", nil, nil, storeErrNotFound
	}

	g := r.game
	if g == nil || g.index != index {
		return "", nil, nil, storeErrNoActiveQuestion
	}

	usernames := make([]string, 0, len(g.scores))
	for username := range g.scores {
		usernames = append(usernames, username)
	}
	slices.Sort(usernames)

	results = make([]QuestionResult, 0, len(usernames))
	for _, username := range usernames {
		entry := QuestionResult{Username: username}

		if a, answered := g.answers[username]; answered {
			option := a.option
			ms := a.elapsed.Milliseconds()
			entry.Option = &option
			entry.Correct = a.correct
			entry.Points = a.points
			entry.MS = &ms

			g.scores[username] += a.points
		}

		results = append(results, entry)
	}

	correctOption = g.correctOption
	board = r.scoreboard()

	g.index = -1
	g.answers = nil
	g.allDone = nil
	g.doneClosed = false

	return correctOption, results, board, storeErrNone
}

func endGame(roomID string) (view RoomView, board []ScoreEntry, sErr storeErr) {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[roomID]
	if !ok {
		return RoomView{}, nil, storeErrNotFound
	}

	board = r.scoreboard()

	r.Started = false
	r.QuestionIDs = nil
	r.game = nil
	for _, m := range r.Members {
		m.ready = false
	}

	return r.view(), board, storeErrNone
}

func broadcast(roomID string, payload []byte) {
	var stalled []*member

	mu.RLock()
	if r, ok := rooms[roomID]; ok {
		for _, m := range r.Members {
			if !m.deliver(payload) {
				stalled = append(stalled, m)
			}
		}
	}
	mu.RUnlock()

	for _, m := range stalled {
		dropStalled(m)
	}
}

func sendTo(m *member, payload []byte) {
	mu.RLock()
	delivered := m.deliver(payload)
	mu.RUnlock()

	if !delivered {
		dropStalled(m)
	}
}

func dropStalled(m *member) {
	mu.Lock()
	defer mu.Unlock()

	roomID, seated := userRoom[m.username]
	if !seated {
		return
	}
	r, ok := rooms[roomID]
	if !ok {
		return
	}
	idx := r.indexOf(m.username)
	if idx < 0 || r.Members[idx] != m {
		return
	}

	m.closeSend()
}

func uniqueRoomIDLocked() (string, error) {
	for range maxIDAttempts {
		id, err := generateRoomID()
		if err != nil {
			return "", err
		}
		if _, taken := rooms[id]; !taken {
			return id, nil
		}
	}
	return "", errIDGenExhausted
}
