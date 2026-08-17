package room

import (
	"crypto/rand"
)

type member struct {
	username string
	send     chan []byte
	closed   bool
}

func (m *member) deliver(payload []byte) {
	if m.send == nil || m.closed || payload == nil {
		return
	}
	select {
	case m.send <- payload:
	default:
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
}

type RoomView struct {
	ID          string   `json:"id"`
	Name        string   `json:"name"`
	Users       []string `json:"users"`
	CategoryIDs []int    `json:"category_ids"`
	HasPassword bool     `json:"has_password"`
}

func (r *Room) view() RoomView {
	users := make([]string, len(r.Members))
	for i, m := range r.Members {
		users[i] = m.username
	}

	categoryIDs := make([]int, len(r.CategoryIDs))
	copy(categoryIDs, r.CategoryIDs)

	return RoomView{
		ID:          r.ID,
		Name:        r.Name,
		Users:       users,
		CategoryIDs: categoryIDs,
		HasPassword: r.PasswordHash != "",
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
