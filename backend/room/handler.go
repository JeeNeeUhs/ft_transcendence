package room

import (
	"strings"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

const (
	minRoomPasswordLen = 2
	maxRoomPasswordLen = 50
)

type createRoomRequest struct {
	Name        string `json:"name"`
	Password    string `json:"password,omitempty"`
	CategoryIDs []int  `json:"category_ids,omitempty"`
}

type joinRoomRequest struct {
	RoomID   string `json:"room_id"`
	Password string `json:"password,omitempty"`
}

func currentUsername(c fiber.Ctx) (string, error) {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return "", fiber.NewError(fiber.StatusUnauthorized)
	}

	var user models.User
	if err := database.DB.First(&user, "id = ?", userID).Error; err != nil {
		return "", err
	}

	return user.Username, nil
}

func createRoomHandler(c fiber.Ctx) error {
	var req createRoomRequest
	if err := c.Bind().Body(&req); err != nil {
		return c.Status(apierr.CodeToStatus(1)).JSON(apierr.CodeToErr(1))
	}

	req.Name = strings.TrimSpace(req.Name)
	if len(req.Name) == 0 || len(req.Name) > 100 {
		return c.Status(apierr.CodeToStatus(18)).JSON(apierr.CodeToErr(18))
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

	r, sErr := createRoom(req.Name, username, pwHash, req.CategoryIDs)
	switch sErr {
	case storeErrAlreadyInOtherRoom:
		return c.Status(apierr.CodeToStatus(20)).JSON(apierr.CodeToErr(20))
	case storeErrIDGenFailed:
		return c.Status(apierr.CodeToStatus(22)).JSON(apierr.CodeToErr(22))
	}

	return c.Status(fiber.StatusCreated).JSON(r.view())
}

func joinRoomHandler(c fiber.Ctx) error {
	var req joinRoomRequest
	if err := c.Bind().Body(&req); err != nil {
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

	r, sErr := joinRoom(req.RoomID, username)
	switch sErr {
	case storeErrNotFound:
		return c.Status(apierr.CodeToStatus(19)).JSON(apierr.CodeToErr(19))
	case storeErrAlreadyInThisRoom:
		return c.Status(apierr.CodeToStatus(21)).JSON(apierr.CodeToErr(21))
	case storeErrAlreadyInOtherRoom:
		return c.Status(apierr.CodeToStatus(20)).JSON(apierr.CodeToErr(20))
	}

	return c.JSON(r.view())
}

func leaveRoomHandler(c fiber.Ctx) error {
	username, err := currentUsername(c)
	if err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}

	if sErr := leaveRoom(username); sErr == storeErrNotInRoom {
		return c.Status(apierr.CodeToStatus(26)).JSON(apierr.CodeToErr(26))
	}

	return c.JSON(fiber.Map{"message": "left room"})
}

func searchRoomsHandler(c fiber.Ctx) error {
	list := listRooms()
	views := make([]RoomView, len(list))
	for i, r := range list {
		views[i] = r.view()
	}

	return c.JSON(fiber.Map{"rooms": views})
}

func existRoomHandler(c fiber.Ctx) error {
	id := strings.TrimSpace(c.Query("id"))
	if !isValidRoomIDFormat(id) {
		return c.JSON(fiber.Map{"exists": false})
	}

	return c.JSON(fiber.Map{"exists": exists(id)})
}
