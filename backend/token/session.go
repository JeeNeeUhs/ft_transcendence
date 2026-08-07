package token

import (
	"sync"

	"github.com/google/uuid"
)

type sessionEntry struct {
	tokenVersion int
	active       bool
}

var (
	sessionsMu sync.RWMutex
	sessions   = make(map[uuid.UUID]*sessionEntry)
)

func Login(userID uuid.UUID) int {
	sessionsMu.Lock()
	defer sessionsMu.Unlock()

	e, ok := sessions[userID]
	if !ok {
		e = &sessionEntry{}
		sessions[userID] = e
	}
	e.active = true
	return e.tokenVersion
}

func IsValid(userID uuid.UUID, tokenVersion int) bool {
	sessionsMu.RLock()
	defer sessionsMu.RUnlock()

	e, ok := sessions[userID]
	return ok && e.active && e.tokenVersion == tokenVersion
}

func Logout(userID uuid.UUID) {
	sessionsMu.Lock()
	defer sessionsMu.Unlock()

	e, ok := sessions[userID]
	if !ok {
		e = &sessionEntry{}
		sessions[userID] = e
	}
	e.tokenVersion++
	e.active = false
}
