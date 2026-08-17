package room

import (
	"encoding/json"
	"sync"
	"time"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/config"
	"github.com/gofiber/contrib/v3/websocket"
	"github.com/gofiber/fiber/v3"
)

const (
	writeWait      = 10 * time.Second
	pongWait       = 60 * time.Second
	pingPeriod     = (pongWait * 9) / 10
	maxMessageSize = 4096
)

const (
	localsUsernameKey = "room_username"
	localsRoomIDKey   = "room_id"
)

const (
	eventRoomState         = "room_state"
	eventUserJoined        = "user_joined"
	eventUserLeft          = "user_left"
	eventCategoriesChanged = "categories_changed"
	eventError             = "error"
)

const (
	actionLeave         = "leave"
	actionSetCategories = "set_categories"
)

type clientMessage struct {
	Type string `json:"type"`
}

type setCategoriesMessage struct {
	CategoryIDs *[]int `json:"category_ids"`
}

type wsEvent struct {
	Type string    `json:"type"`
	User string    `json:"user,omitempty"`
	Room *RoomView `json:"room,omitempty"`
}

type wsErrorEvent struct {
	Type    string `json:"type"`
	Code    int    `json:"code"`
	Message string `json:"message"`
}

func encodeEvent(e wsEvent) []byte {
	payload, err := json.Marshal(e)
	if err != nil {
		return nil
	}
	return payload
}

func encodeError(code int) []byte {
	body := apierr.CodeToErr(code)
	payload, err := json.Marshal(wsErrorEvent{
		Type:    eventError,
		Code:    body.Code,
		Message: body.Message,
	})
	if err != nil {
		return nil
	}
	return payload
}

var upgradeJoin fiber.Handler = websocket.New(joinConnHandler, websocket.Config{
	Origins:         config.CorsAllowedOrigins,
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
})

func joinConnHandler(conn *websocket.Conn) {
	username, _ := conn.Locals(localsUsernameKey).(string)
	roomID, _ := conn.Locals(localsRoomIDKey).(string)
	if username == "" || roomID == "" {
		closeWithError(conn, 13)
		return
	}

	m, view, sErr := attach(roomID, username)
	if sErr != storeErrNone {
		closeWithError(conn, storeErrToCode(sErr))
		return
	}

	var wg sync.WaitGroup
	wg.Add(1)
	go func() {
		defer wg.Done()
		writePump(conn, m.send)
	}()

	sendTo(m, encodeEvent(wsEvent{Type: eventRoomState, User: username, Room: &view}))
	broadcast(roomID, encodeEvent(wsEvent{Type: eventUserJoined, User: username, Room: &view}))

	readPump(conn, m, roomID, username)

	if id, remaining, ok := detach(username, m); ok {
		broadcast(id, encodeEvent(wsEvent{Type: eventUserLeft, User: username, Room: &remaining}))
	}

	wg.Wait()
}

func readPump(conn *websocket.Conn, m *member, roomID, username string) {
	conn.SetReadLimit(maxMessageSize)
	_ = conn.SetReadDeadline(time.Now().Add(pongWait))
	conn.SetPongHandler(func(string) error {
		return conn.SetReadDeadline(time.Now().Add(pongWait))
	})

	for {
		_, data, err := conn.ReadMessage()
		if err != nil {
			return
		}

		var msg clientMessage
		if err := json.Unmarshal(data, &msg); err != nil {
			sendTo(m, encodeError(1))
			continue
		}

		switch msg.Type {
		case actionLeave:
			return

		case actionSetCategories:
			setCategoriesAction(m, roomID, username, data)

		default:
			sendTo(m, encodeError(1))
		}
	}
}

func setCategoriesAction(m *member, roomID, username string, data []byte) {
	var msg setCategoriesMessage
	if err := json.Unmarshal(data, &msg); err != nil || msg.CategoryIDs == nil {
		sendTo(m, encodeError(1))
		return
	}
	ids := *msg.CategoryIDs

	if hasDuplicateInts(ids) {
		sendTo(m, encodeError(29))
		return
	}

	valid, err := checkCategoryIDs(ids)
	if err != nil {
		sendTo(m, encodeError(5))
		return
	}
	if !valid {
		sendTo(m, encodeError(28))
		return
	}

	view, sErr := setCategories(roomID, ids)
	if sErr != storeErrNone {
		sendTo(m, encodeError(storeErrToCode(sErr)))
		return
	}

	broadcast(roomID, encodeEvent(wsEvent{
		Type: eventCategoriesChanged,
		User: username,
		Room: &view,
	}))
}

func writePump(conn *websocket.Conn, send <-chan []byte) {
	ticker := time.NewTicker(pingPeriod)
	defer func() {
		ticker.Stop()
		_ = conn.Close()
	}()

	for {
		select {
		case payload, ok := <-send:
			_ = conn.SetWriteDeadline(time.Now().Add(writeWait))
			if !ok {
				_ = conn.WriteMessage(websocket.CloseMessage,
					websocket.FormatCloseMessage(websocket.CloseNormalClosure, ""))
				return
			}
			if err := conn.WriteMessage(websocket.TextMessage, payload); err != nil {
				return
			}
		case <-ticker.C:
			_ = conn.SetWriteDeadline(time.Now().Add(writeWait))
			if err := conn.WriteMessage(websocket.PingMessage, nil); err != nil {
				return
			}
		}
	}
}

func closeWithError(conn *websocket.Conn, code int) {
	_ = conn.SetWriteDeadline(time.Now().Add(writeWait))
	if payload := encodeError(code); payload != nil {
		_ = conn.WriteMessage(websocket.TextMessage, payload)
	}
	_ = conn.WriteMessage(websocket.CloseMessage,
		websocket.FormatCloseMessage(websocket.ClosePolicyViolation, apierr.CodeToErr(code).Message))
	_ = conn.Close()
}

func storeErrToCode(sErr storeErr) int {
	switch sErr {
	case storeErrNotFound:
		return 19
	case storeErrAlreadyInOtherRoom:
		return 20
	case storeErrAlreadyInThisRoom:
		return 21
	default:
		return 0
	}
}
