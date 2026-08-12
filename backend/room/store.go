package room

import (
	"errors"
	"sync"
)

var errIDGenExhausted = errors.New("room: exhausted id generation attempts")

type storeErr int

const (
	storeErrNone               = 0
	storeErrNotFound           = 1
	storeErrAlreadyInThisRoom  = 2
	storeErrAlreadyInOtherRoom = 3
	storeErrIDGenFailed        = 4
	storeErrNotInRoom          = 5
)

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

func listRooms() []Room {
	mu.RLock()
	defer mu.RUnlock()

	list := make([]Room, 0, len(rooms))
	for _, r := range rooms {
		list = append(list, copyRoom(r))
	}
	return list
}

func createRoom(name, creatorUsername, pwHash string, categoryIDs []int) (Room, storeErr) {
	mu.Lock()
	defer mu.Unlock()

	if _, ok := userRoom[creatorUsername]; ok {
		return Room{}, storeErrAlreadyInOtherRoom
	}

	id, err := uniqueRoomIDLocked()
	if err != nil {
		return Room{}, storeErrIDGenFailed
	}

	r := &Room{
		ID:           id,
		Name:         name,
		Users:        []string{creatorUsername},
		CategoryIDs:  categoryIDs,
		PasswordHash: pwHash,
	}
	rooms[id] = r
	userRoom[creatorUsername] = id

	return copyRoom(r), storeErrNone
}

func joinRoom(id, username string) (Room, storeErr) {
	mu.Lock()
	defer mu.Unlock()

	r, ok := rooms[id]
	if !ok {
		return Room{}, storeErrNotFound
	}

	if current, inRoom := userRoom[username]; inRoom {
		if current == id {
			return Room{}, storeErrAlreadyInThisRoom
		}
		return Room{}, storeErrAlreadyInOtherRoom
	}

	r.Users = append(r.Users, username)
	userRoom[username] = id

	return copyRoom(r), storeErrNone
}

func leaveRoom(username string) storeErr {
	mu.Lock()
	defer mu.Unlock()

	id, ok := userRoom[username]
	if !ok {
		return storeErrNotInRoom
	}
	delete(userRoom, username)

	if r, ok := rooms[id]; ok {
		r.Users = removeString(r.Users, username)
		if len(r.Users) == 0 {
			delete(rooms, id)
		}
	}

	return storeErrNone
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

func removeString(list []string, target string) []string {
	filtered := list[:0]
	for _, s := range list {
		if s != target {
			filtered = append(filtered, s)
		}
	}
	return filtered
}

func copyRoom(r *Room) Room {
	users := make([]string, len(r.Users))
	copy(users, r.Users)

	categoryIDs := make([]int, len(r.CategoryIDs))
	copy(categoryIDs, r.CategoryIDs)

	return Room{
		ID:           r.ID,
		Name:         r.Name,
		Users:        users,
		CategoryIDs:  categoryIDs,
		PasswordHash: r.PasswordHash,
	}
}
