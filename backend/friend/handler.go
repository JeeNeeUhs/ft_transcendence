package friend

import (
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
)


type SendRequestInput struct {
	AddresseeUsername string `json:"username"`
}


func SendRequestHandler(c fiber.Ctx) error {
	
	requesterID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized"})
	}

	
	
	var input SendRequestInput
	if err := c.Bind().Body(&input); err != nil || input.AddresseeUsername == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body or empty username"})
	}

	var destUser struct {
		ID uuid.UUID
	}
	
	err := database.DB.Table("users").Select("id").Where("username = ?", input.AddresseeUsername).First(&destUser).Error
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "user not found in db"})
	}
	addresseeID := destUser.ID
	
	insertQuery := `INSERT INTO friendships (requester_id, addressee_id, status) VALUES (?, ?, 'pending')`
	if err := database.DB.Exec(insertQuery, requesterID, addresseeID).Error; err != nil {
		return c.Status(fiber.StatusConflict).JSON(fiber.Map{"error": "friend request already exists or invalid"})
	}

	return c.Status(fiber.StatusCreated).JSON(fiber.Map{
		"message": "friend request sent successfully",
	})
}


type AcceptRequestInput struct {
	RequesterUsername string `json:"username"`
}


func AcceptRequestHandler(c fiber.Ctx) error {
	addresseeID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized"})
	}

	var input AcceptRequestInput
	if err := c.Bind().Body(&input); err != nil || input.RequesterUsername == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body or empty username"})
	}

	var reqUser struct {
		ID uuid.UUID
	}
	err := database.DB.Table("users").Select("id").Where("username = ?", input.RequesterUsername).First(&reqUser).Error
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "requester not found in db"})
	}
	requesterID := reqUser.ID

	updateQuery := `UPDATE friendships SET status = 'accepted' WHERE requester_id = ? AND addressee_id = ? AND status = 'pending'`
	result := database.DB.Exec(updateQuery, requesterID, addresseeID)
	
	if result.Error != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "database error"})
	}
	if result.RowsAffected == 0 {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "no pending friend request found from this user"})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "friend request accepted successfully",
	})
}

type UserResponse struct {
	Username  string `json:"username"`
	AvatarURL string `json:"avatar_url"`
	Status    int64  `json:"status"`
}


func GetRequestsHandler(c fiber.Ctx) error {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized"})
	}

	var requests []UserResponse
	query := `
		SELECT u.username, u.avatar_url, u.status
		FROM users u
		INNER JOIN friendships f ON u.id = f.requester_id
		WHERE f.addressee_id = ? AND f.status = 'pending'
	`
	if err := database.DB.Raw(query, userID).Scan(&requests).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "database error"})
	}

	if requests == nil {
		requests = []UserResponse{}
	}
	return c.Status(fiber.StatusOK).JSON(requests)
}


func GetFriendsHandler(c fiber.Ctx) error {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized"})
	}

	var friends []UserResponse
	query := `
		SELECT u.username, u.avatar_url, u.status
		FROM users u
		INNER JOIN friendships f ON (u.id = f.requester_id OR u.id = f.addressee_id)
		WHERE (f.requester_id = ? OR f.addressee_id = ?) 
		  AND f.status = 'accepted'
		  AND u.id != ?
	`
	if err := database.DB.Raw(query, userID, userID, userID).Scan(&friends).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "database error"})
	}

	if friends == nil {
		friends = []UserResponse{}
	}
	return c.Status(fiber.StatusOK).JSON(friends)
}