package room

import (
	"encoding/json"
	"strings"
	"sync"
	"time"
	"unicode/utf8"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/config"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/gofiber/contrib/v3/websocket"
	"github.com/gofiber/fiber/v3"
)

const (
	writeWait      = 10 * time.Second
	pongWait       = 60 * time.Second
	pingPeriod     = (pongWait * 9) / 10
	maxMessageSize = 64 * 1024
	maxFrameSize   = 8 * 1024
)

const maxChatMessageLen = 500

const (
	localsUsernameKey = "room_username"
	localsRoomIDKey   = "room_id"
)

const (
	eventRoomState      = "room_state"
	eventUserJoined     = "user_joined"
	eventUserLeft       = "user_left"
	eventChatMessage    = "chat_message"
	eventReadyChanged   = "ready_changed"
	eventCountdown      = "countdown"
	eventQuestion       = "question"
	eventAnswerReceived = "answer_received"
	eventQuestionResult = "question_result"
	eventFinish         = "finish"
	eventError          = "error"
)

const (
	actionLeave  = "leave"
	actionChat   = "chat"
	actionReady  = "ready"
	actionAnswer = "answer"
)

const countdownFrom = 3

var (
	countdownTick    = time.Second
	answerWindow     = 20 * time.Second
	interQuestionGap = 3 * time.Second
)

type clientMessage struct {
	Type string `json:"type"`
}

type chatMessage struct {
	Message *string `json:"message"`
}

type readyMessage struct {
	Ready *bool `json:"ready"`
}

type answerMessage struct {
	Index  *int    `json:"index"`
	Option *string `json:"option"`
}

type wsEvent struct {
	Type    string    `json:"type"`
	User    string    `json:"user,omitempty"`
	Message string    `json:"message,omitempty"`
	Room    *RoomView `json:"room,omitempty"`
}

type wsErrorEvent struct {
	Type    string `json:"type"`
	Code    int    `json:"code"`
	Message string `json:"message"`
}

type wsCountdownEvent struct {
	Type  string `json:"type"`
	Value int    `json:"value"`
}

type wsReadyEvent struct {
	Type  string    `json:"type"`
	User  string    `json:"user"`
	Ready bool      `json:"ready"`
	Room  *RoomView `json:"room"`
}

type wsQuestionEvent struct {
	Type     string          `json:"type"`
	Index    int             `json:"index"`
	Total    int             `json:"total"`
	Duration int             `json:"duration"`
	Question models.Question `json:"question"`
}

type wsAnswerReceivedEvent struct {
	Type     string `json:"type"`
	User     string `json:"user"`
	Answered int    `json:"answered"`
	Total    int    `json:"total"`
}

type wsQuestionResultEvent struct {
	Type          string           `json:"type"`
	Index         int              `json:"index"`
	CorrectOption string           `json:"correct_option"`
	Results       []QuestionResult `json:"results"`
	Scoreboard    []ScoreEntry     `json:"scoreboard"`
}

type wsFinishEvent struct {
	Type       string       `json:"type"`
	Scoreboard []ScoreEntry `json:"scoreboard"`
	Room       *RoomView    `json:"room"`
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

func encodeCountdown(value int) []byte {
	payload, err := json.Marshal(wsCountdownEvent{Type: eventCountdown, Value: value})
	if err != nil {
		return nil
	}
	return payload
}

func encodeReady(username string, ready bool, view RoomView) []byte {
	payload, err := json.Marshal(wsReadyEvent{
		Type:  eventReadyChanged,
		User:  username,
		Ready: ready,
		Room:  &view,
	})
	if err != nil {
		return nil
	}
	return payload
}

func encodeQuestion(index, total int, q models.Question) []byte {
	payload, err := json.Marshal(wsQuestionEvent{
		Type:     eventQuestion,
		Index:    index,
		Total:    total,
		Duration: int(answerWindow.Seconds()),
		Question: q,
	})
	if err != nil {
		return nil
	}
	return payload
}

func encodeAnswerReceived(username string, answered, total int) []byte {
	payload, err := json.Marshal(wsAnswerReceivedEvent{
		Type:     eventAnswerReceived,
		User:     username,
		Answered: answered,
		Total:    total,
	})
	if err != nil {
		return nil
	}
	return payload
}

func encodeQuestionResult(index int, correctOption string, results []QuestionResult, board []ScoreEntry) []byte {
	payload, err := json.Marshal(wsQuestionResultEvent{
		Type:          eventQuestionResult,
		Index:         index,
		CorrectOption: correctOption,
		Results:       results,
		Scoreboard:    board,
	})
	if err != nil {
		return nil
	}
	return payload
}

func encodeFinish(board []ScoreEntry, view RoomView) []byte {
	payload, err := json.Marshal(wsFinishEvent{
		Type:       eventFinish,
		Scoreboard: board,
		Room:       &view,
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

		if !isCurrentSession(roomID, m) {
			return
		}

		if len(data) > maxFrameSize {
			sendTo(m, encodeError(35))
			continue
		}

		var msg clientMessage
		if err := json.Unmarshal(data, &msg); err != nil {
			sendTo(m, encodeError(1))
			continue
		}

		switch msg.Type {
		case actionLeave:
			return

		case actionChat:
			chatAction(m, roomID, username, data)

		case actionReady:
			readyAction(m, roomID, username, data)

		case actionAnswer:
			answerAction(m, roomID, username, data)

		default:
			sendTo(m, encodeError(1))
		}
	}
}

func chatAction(m *member, roomID, username string, data []byte) {
	var msg chatMessage
	if err := json.Unmarshal(data, &msg); err != nil || msg.Message == nil {
		sendTo(m, encodeError(1))
		return
	}

	text := strings.TrimSpace(*msg.Message)
	if text == "" {
		sendTo(m, encodeError(31))
		return
	}
	if utf8.RuneCountInString(text) > maxChatMessageLen {
		sendTo(m, encodeError(35))
		return
	}

	broadcast(roomID, encodeEvent(wsEvent{
		Type:    eventChatMessage,
		User:    username,
		Message: text,
	}))
}

func readyAction(m *member, roomID, username string, data []byte) {
	var msg readyMessage
	if err := json.Unmarshal(data, &msg); err != nil || msg.Ready == nil {
		sendTo(m, encodeError(1))
		return
	}
	ready := *msg.Ready

	view, allReady, sErr := setReady(roomID, m, ready)
	if sErr == storeErrStaleSession {
		return
	}
	if sErr != storeErrNone {
		sendTo(m, encodeError(storeErrToCode(sErr)))
		return
	}

	broadcast(roomID, encodeReady(username, ready, view))

	if allReady {
		go beginGame(m, roomID)
	}
}

func answerAction(m *member, roomID, username string, data []byte) {
	var msg answerMessage
	if err := json.Unmarshal(data, &msg); err != nil || msg.Index == nil || msg.Option == nil {
		sendTo(m, encodeError(1))
		return
	}

	option := strings.ToUpper(strings.TrimSpace(*msg.Option))

	answered, total, sErr := recordAnswer(roomID, m, *msg.Index, option)
	if sErr == storeErrStaleSession {
		return
	}
	if sErr != storeErrNone {
		sendTo(m, encodeError(storeErrToCode(sErr)))
		return
	}

	broadcast(roomID, encodeAnswerReceived(username, answered, total))
}

func beginGame(m *member, roomID string) {
	categoryIDs, lang, sErr := claimGameStart(roomID)
	if sErr == storeErrNotReady || sErr == storeErrAlreadyStarted {
		return
	}
	if sErr != storeErrNone {
		sendTo(m, encodeError(storeErrToCode(sErr)))
		return
	}

	questionIDs, err := pickQuestionIDsFn(categoryIDs, lang)
	if err != nil {
		abortGameStart(roomID)
		sendTo(m, encodeError(5))
		return
	}

	if sErr := startGame(roomID, questionIDs); sErr != storeErrNone {
		sendTo(m, encodeError(storeErrToCode(sErr)))
		return
	}

	runCountdown(roomID)
	runGame(roomID, questionIDs)
}

func runGame(roomID string, questionIDs []int) {
	for index, questionID := range questionIDs {
		if !exists(roomID) {
			return
		}

		q, err := fetchQuestionFn(questionID)
		if err != nil {
			abandonGame(roomID, 5)
			return
		}

		done, sErr := startQuestion(roomID, index, questionID, q.CorrectOption)
		if sErr != storeErrNone {
			return
		}

		broadcast(roomID, encodeQuestion(index, len(questionIDs), q))

		timer := time.NewTimer(answerWindow)
		select {
		case <-done:
			timer.Stop()
		case <-timer.C:
		}

		correctOption, results, board, sErr := finishQuestion(roomID, index)
		if sErr != storeErrNone {
			return
		}
		broadcast(roomID, encodeQuestionResult(index, correctOption, results, board))

		if index < len(questionIDs)-1 {
			time.Sleep(interQuestionGap)
		}
	}

	view, board, sErr := endGame(roomID)
	if sErr != storeErrNone {
		return
	}
	broadcast(roomID, encodeFinish(board, view))
}

func abandonGame(roomID string, code int) {
	view, _, sErr := endGame(roomID)
	if sErr != storeErrNone {
		return
	}
	broadcast(roomID, encodeError(code))
	broadcast(roomID, encodeEvent(wsEvent{Type: eventRoomState, Room: &view}))
}

func runCountdown(roomID string) {
	for value := countdownFrom; value >= 1; value-- {
		if !exists(roomID) {
			return
		}
		broadcast(roomID, encodeCountdown(value))
		time.Sleep(countdownTick)
	}
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
