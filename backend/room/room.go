package room

import (
	"crypto/rand"
)

type Room struct {
	ID           string
	Name         string
	Users        []string
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

func (r Room) view() RoomView {
	return RoomView{
		ID:          r.ID,
		Name:        r.Name,
		Users:       r.Users,
		CategoryIDs: r.CategoryIDs,
		HasPassword: r.PasswordHash != "",
	}
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
