package room

import (
	"errors"
	"sync"
)

var errIDGenExhausted = errors.New("room: exhausted id generation attempts")

type storeErr int

const (
	storeErrNone storeErr = iota
	storeErrNotFound
	storeErrAlreadyInThisRoom
	storeErrAlreadyInOtherRoom
	storeErrIDGenFailed
	storeErrNotInRoom
)

const sendBufferSize = 16

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

func listRooms() []RoomView {
	mu.RLock()
	defer mu.RUnlock()

	list := make([]RoomView, 0, len(rooms))
	for _, r := range rooms {
		list = append(list, r.view())
	}
	return list
}

func createRoom(name, creatorUsername, pwHash string, categoryIDs []int) (RoomView, storeErr) {
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
	}
	rooms[id] = r
	userRoom[creatorUsername] = id

	return r.view(), storeErrNone
}

func checkJoinable(roomID, username string) storeErr {
	mu.RLock()
	defer mu.RUnlock()

	if _, ok := rooms[roomID]; !ok {
		return storeErrNotFound
	}
	if current, inRoom := userRoom[username]; inRoom && current != roomID {
		return storeErrAlreadyInOtherRoom
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

	if idx := r.indexOf(username); idx >= 0 {
		r.Members[idx].closeSend()
		r.Members[idx] = m
	} else {
		r.Members = append(r.Members, m)
		userRoom[username] = roomID
	}

	return m, r.view(), storeErrNone
}

func detach(username string, m *member) (roomID string, view RoomView, ok bool) {
	mu.Lock()
	defer mu.Unlock()

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

	m.closeSend()
	r.Members = append(r.Members[:idx], r.Members[idx+1:]...)
	delete(userRoom, username)

	if len(r.Members) == 0 {
		delete(rooms, id)
		return "", RoomView{}, false
	}

	return id, r.view(), true
}

func leaveRoom(username string) (roomID string, view RoomView, announce bool, sErr storeErr) {
	mu.Lock()
	defer mu.Unlock()

	id, ok := userRoom[username]
	if !ok {
		return "", RoomView{}, false, storeErrNotInRoom
	}
	delete(userRoom, username)

	r, roomOK := rooms[id]
	if !roomOK {
		return "", RoomView{}, false, storeErrNone
	}

	if idx := r.indexOf(username); idx >= 0 {
		r.Members[idx].closeSend()
		r.Members = append(r.Members[:idx], r.Members[idx+1:]...)
	}

	if len(r.Members) == 0 {
		delete(rooms, id)
		return "", RoomView{}, false, storeErrNone
	}

	return id, r.view(), true, storeErrNone
}

func setCategories(roomID string, categoryIDs []int) (RoomView, storeErr) {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[roomID]
	if !ok {
		return RoomView{}, storeErrNotFound
	}

	ids := make([]int, len(categoryIDs))
	copy(ids, categoryIDs)
	r.CategoryIDs = ids

	return r.view(), storeErrNone
}

func broadcast(roomID string, payload []byte) {
	mu.RLock()
	defer mu.RUnlock()

	r, ok := rooms[roomID]
	if !ok {
		return
	}
	for _, m := range r.Members {
		m.deliver(payload)
	}
}

func sendTo(m *member, payload []byte) {
	mu.RLock()
	defer mu.RUnlock()

	m.deliver(payload)
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
