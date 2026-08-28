package room

import (
	"cmp"
	"crypto/rand"
	"math"
	"slices"
	"time"
)

const minPlayersToStart = 2
const maxPlayersPerRoom = 20

func (r *Room) isFull() bool {
	return len(r.Members) >= maxPlayersPerRoom
}

func (r *Room) hasConnectedMember() bool {
	for _, m := range r.Members {
		if !m.awaitingConnection() {
			return true
		}
	}
	return false
}

var supportedLangs = map[string]struct{}{
	"tr": {},
	"en": {},
	"es": {},
}

func isSupportedLang(lang string) bool {
	_, ok := supportedLangs[lang]
	return ok
}

var validOptions = map[string]struct{}{"A": {}, "B": {}, "C": {}, "D": {}}

func isValidOption(option string) bool {
	_, ok := validOptions[option]
	return ok
}

type member struct {
	username string
	send     chan []byte
	closed   bool
	ready    bool
}

// A seat created by createRoom has no socket yet: the WebSocket upgrade only
// runs once the room exists. That placeholder is the one and only seat attach
// is allowed to take over.
func (m *member) awaitingConnection() bool {
	return m.send == nil
}

func (m *member) deliver(payload []byte) bool {
	if m.send == nil || m.closed || payload == nil {
		return true
	}
	select {
	case m.send <- payload:
		return true
	default:
		return false
	}
}

func (m *member) closeSend() {
	if m.send == nil || m.closed {
		return
	}
	m.closed = true
	close(m.send)
}

type Room struct {
	ID           string
	Name         string
	Members      []*member
	CategoryIDs  []int
	PasswordHash string
	Creator      string
	Lang         string
	CreatedAt    int64
	Started      bool
	QuestionIDs  []int
	game         *gameState
}

type gameState struct {
	scores        map[string]int
	index         int
	questionID    int
	correctOption string
	startedAt     time.Time
	answers       map[string]answerRecord
	allDone       chan struct{}
	doneClosed    bool
}

type answerRecord struct {
	option  string
	correct bool
	points  int
	elapsed time.Duration
}

type ScoreEntry struct {
	Username string `json:"username"`
	Score    int    `json:"score"`
	Rank     int    `json:"rank"`
}

type QuestionResult struct {
	Username string  `json:"username"`
	Option   *string `json:"option"`
	Correct  bool    `json:"correct"`
	Points   int     `json:"points"`
	MS       *int64  `json:"ms"`
}

const (
	maxQuestionPoints = 1000
	fullScoreWithin   = time.Second
)

func scoreFor(elapsed time.Duration) int {
	if elapsed <= fullScoreWithin {
		return maxQuestionPoints
	}
	if elapsed >= answerWindow {
		return 0
	}

	span := (answerWindow - fullScoreWithin).Seconds()
	left := (answerWindow - elapsed).Seconds()

	return int(math.Round(maxQuestionPoints * left / span))
}

func (r *Room) scoreboard() []ScoreEntry {
	if r.game == nil {
		return []ScoreEntry{}
	}

	board := make([]ScoreEntry, 0, len(r.game.scores))
	for username, score := range r.game.scores {
		board = append(board, ScoreEntry{Username: username, Score: score})
	}

	slices.SortFunc(board, func(a, b ScoreEntry) int {
		if c := cmp.Compare(b.Score, a.Score); c != 0 {
			return c
		}
		return cmp.Compare(a.Username, b.Username)
	})

	for i := range board {
		if i > 0 && board[i].Score == board[i-1].Score {
			board[i].Rank = board[i-1].Rank
			continue
		}
		board[i].Rank = i + 1
	}

	return board
}

type UserView struct {
	Username string `json:"username"`
	Ready    bool   `json:"ready"`
}

type RoomView struct {
	ID          string     `json:"id"`
	Name        string     `json:"name"`
	Creator     string     `json:"creator"`
	Users       []UserView `json:"users"`
	CategoryIDs []int      `json:"category_ids"`
	Lang        string     `json:"lang"`
	CreatedAt   int64      `json:"created_at"`
	HasPassword bool       `json:"has_password"`
	Started     bool       `json:"started"`
}

type RoomListView struct {
	ID          string `json:"id"`
	Name        string `json:"name"`
	Creator     string `json:"creator"`
	UserCount   int    `json:"user_count"`
	CategoryIDs []int  `json:"category_ids"`
	Lang        string `json:"lang"`
	CreatedAt   int64  `json:"created_at"`
	HasPassword bool   `json:"has_password"`
	Started     bool   `json:"started"`
}

func (r *Room) allReady() bool {
	if len(r.Members) < minPlayersToStart {
		return false
	}
	for _, m := range r.Members {
		if !m.ready {
			return false
		}
	}
	return true
}

func (r *Room) view() RoomView {
	users := make([]UserView, len(r.Members))
	for i, m := range r.Members {
		users[i] = UserView{Username: m.username, Ready: m.ready}
	}

	categoryIDs := make([]int, len(r.CategoryIDs))
	copy(categoryIDs, r.CategoryIDs)

	return RoomView{
		ID:          r.ID,
		Name:        r.Name,
		Creator:     r.Creator,
		Users:       users,
		CategoryIDs: categoryIDs,
		Lang:        r.Lang,
		CreatedAt:   r.CreatedAt,
		HasPassword: r.PasswordHash != "",
		Started:     r.Started,
	}
}

func (r *Room) listView() RoomListView {
	categoryIDs := make([]int, len(r.CategoryIDs))
	copy(categoryIDs, r.CategoryIDs)

	return RoomListView{
		ID:          r.ID,
		Name:        r.Name,
		Creator:     r.Creator,
		UserCount:   len(r.Members),
		CategoryIDs: categoryIDs,
		Lang:        r.Lang,
		CreatedAt:   r.CreatedAt,
		HasPassword: r.PasswordHash != "",
		Started:     r.Started,
	}
}

func (r *Room) indexOf(username string) int {
	for i, m := range r.Members {
		if m.username == username {
			return i
		}
	}
	return -1
}

const (
	roomIDLength  = 8
	roomIDCharset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	maxIDAttempts = 20
)

func generateRoomID() (string, error) {
	const maxByte = 256 - (256 % len(roomIDCharset))

	id := make([]byte, roomIDLength)
	buf := make([]byte, 1)
	for i := 0; i < roomIDLength; {
		if _, err := rand.Read(buf); err != nil {
			return "", err
		}
		if int(buf[0]) >= maxByte {
			continue
		}
		id[i] = roomIDCharset[int(buf[0])%len(roomIDCharset)]
		i++
	}
	return string(id), nil
}

func isValidRoomIDFormat(s string) bool {
	if len(s) != roomIDLength {
		return false
	}
	for i := 0; i < len(s); i++ {
		if s[i] < 'A' || s[i] > 'Z' {
			return false
		}
	}
	return true
}
