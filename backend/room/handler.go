package room

import (
	"errors"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/gofiber/contrib/v3/websocket"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

const (
	minRoomPasswordLen = 2
	maxRoomPasswordLen = 50
)

const maxRoomNameLen = 30

type createRoomRequest struct {
	Name        string `query:"name"`
	Password    string `query:"password"`
	CategoryIDs []int  `query:"category_ids"`
	Lang        string `query:"lang"`
}

type joinRoomRequest struct {
	RoomID   string `query:"room_id"`
	Password string `query:"password"`
}

var errNoAuthenticatedUser = errors.New("room: no authenticated user in context")

func currentUsername(c fiber.Ctx) (string, error) {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return "", errNoAuthenticatedUser
	}

	var user models.User
	if err := database.DB.First(&user, "id = ?", userID).Error; err != nil {
		return "", err
	}

	return user.Username, nil
}

func createRoomHandler(c fiber.Ctx) error {
	if !websocket.IsWebSocketUpgrade(c) {
		return c.Status(apierr.CodeToStatus(30)).JSON(apierr.CodeToErr(30))
	}

	var req createRoomRequest
	if err := c.Bind().Query(&req); err != nil {
		return c.Status(apierr.CodeToStatus(1)).JSON(apierr.CodeToErr(1))
	}

	req.Name = strings.TrimSpace(req.Name)
	if nameLen := utf8.RuneCountInString(req.Name); nameLen == 0 || nameLen > maxRoomNameLen {
		return c.Status(apierr.CodeToStatus(18)).JSON(apierr.CodeToErr(18))
	}

	req.Lang = strings.ToLower(strings.TrimSpace(req.Lang))
	if !isSupportedLang(req.Lang) {
		return c.Status(apierr.CodeToStatus(34)).JSON(apierr.CodeToErr(34))
	}

	var pwHash string
	if req.Password != "" {
		if len(req.Password) < minRoomPasswordLen || len(req.Password) > maxRoomPasswordLen {
			return c.Status(apierr.CodeToStatus(23)).JSON(apierr.CodeToErr(23))
		}
		hash, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
		if err != nil {
			return c.Status(apierr.CodeToStatus(0)).JSON(apierr.CodeToErr(0))
		}
		pwHash = string(hash)
	}

	if len(req.CategoryIDs) == 0 {
		return c.Status(apierr.CodeToStatus(32)).JSON(apierr.CodeToErr(32))
	}

	if hasDuplicateInts(req.CategoryIDs) {
		return c.Status(apierr.CodeToStatus(29)).JSON(apierr.CodeToErr(29))
	}

	valid, err := checkCategoryIDs(req.CategoryIDs)
	if err != nil {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}
	if !valid {
		return c.Status(apierr.CodeToStatus(28)).JSON(apierr.CodeToErr(28))
	}

	username, err := currentUsername(c)
	if err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}

	view, sErr := createRoom(req.Name, username, pwHash, req.CategoryIDs, req.Lang)
	switch sErr {
	case storeErrAlreadyInOtherRoom:
		return c.Status(apierr.CodeToStatus(20)).JSON(apierr.CodeToErr(20))
	case storeErrIDGenFailed:
		return c.Status(apierr.CodeToStatus(22)).JSON(apierr.CodeToErr(22))
	}

	c.Locals(localsUsernameKey, username)
	c.Locals(localsRoomIDKey, view.ID)

	if err := upgradeJoin(c); err != nil {
		leaveRoom(username)
		return c.Status(apierr.CodeToStatus(30)).JSON(apierr.CodeToErr(30))
	}

	// The hijacked connection runs after this handler returns, and it never
	// runs at all if writing the 101 fails or the client walks away right
	// after it. Nothing else would then clear the seat createRoom reserved,
	// and since attach no longer takes over a live seat, that would strand
	// both the room and the account for good.
	time.AfterFunc(reservationGrace, func() {
		if id, remaining, ok := releaseUnconnectedSeat(username, view.ID); ok {
			broadcast(id, encodeEvent(wsEvent{Type: eventUserLeft, User: username, Room: &remaining}))
		}
	})

	return nil
}

func joinRoomHandler(c fiber.Ctx) error {
	if !websocket.IsWebSocketUpgrade(c) {
		return c.Status(apierr.CodeToStatus(30)).JSON(apierr.CodeToErr(30))
	}

	var req joinRoomRequest
	if err := c.Bind().Query(&req); err != nil {
		return c.Status(apierr.CodeToStatus(1)).JSON(apierr.CodeToErr(1))
	}

	req.RoomID = strings.TrimSpace(req.RoomID)
	if !isValidRoomIDFormat(req.RoomID) {
		return c.Status(apierr.CodeToStatus(19)).JSON(apierr.CodeToErr(19))
	}

	hash, found := passwordHash(req.RoomID)
	if !found {
		return c.Status(apierr.CodeToStatus(19)).JSON(apierr.CodeToErr(19))
	}
	if hash != "" {
		if req.Password == "" || bcrypt.CompareHashAndPassword([]byte(hash), []byte(req.Password)) != nil {
			return c.Status(apierr.CodeToStatus(24)).JSON(apierr.CodeToErr(24))
		}
	}

	username, err := currentUsername(c)
	if err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}

	if sErr := checkJoinable(req.RoomID, username); sErr != storeErrNone {
		code := storeErrToCode(sErr)
		return c.Status(apierr.CodeToStatus(code)).JSON(apierr.CodeToErr(code))
	}

	c.Locals(localsUsernameKey, username)
	c.Locals(localsRoomIDKey, req.RoomID)

	if err := upgradeJoin(c); err != nil {
		return c.Status(apierr.CodeToStatus(30)).JSON(apierr.CodeToErr(30))
	}

	return nil
}

func listRoomsHandler(c fiber.Ctx) error {
	return c.JSON(fiber.Map{"rooms": listRooms()})
}

func existRoomHandler(c fiber.Ctx) error {
	id := strings.TrimSpace(c.Query("id"))
	if !isValidRoomIDFormat(id) {
		return c.JSON(fiber.Map{"exists": false})
	}

	return c.JSON(fiber.Map{"exists": exists(id)})
}
