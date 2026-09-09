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
	if err := database.DB.Table("users").Select("id").Where("username = ?", input.AddresseeUsername).First(&destUser).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "user not found in db"})
	}
	addresseeID := destUser.ID

	if requesterID == addresseeID {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "cannot send request to yourself"})
	}

	var incomingRequestCount int64
	database.DB.Table("friendships").
		Where("requester_id = ? AND addressee_id = ? AND status = 'pending'", addresseeID, requesterID).
		Count(&incomingRequestCount)

	if incomingRequestCount > 0 {
		updateQuery := `UPDATE friendships SET status = 'accepted' WHERE requester_id = ? AND addressee_id = ? AND status = 'pending'`
		if err := database.DB.Exec(updateQuery, addresseeID, requesterID).Error; err != nil {
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "database error during auto-accept"})
		}
		return c.Status(fiber.StatusOK).JSON(fiber.Map{
			"message": "friend request automatically accepted",
		})
	}

	var existingRelation int64
	database.DB.Table("friendships").
		Where("(requester_id = ? AND addressee_id = ?) OR (requester_id = ? AND addressee_id = ?)", requesterID, addresseeID, addresseeID, requesterID).
		Count(&existingRelation)

	if existingRelation > 0 {
		return c.Status(fiber.StatusConflict).JSON(fiber.Map{"error": "friendship or request already exists"})
	}

	insertQuery := `INSERT INTO friendships (requester_id, addressee_id, status) VALUES (?, ?, 'pending')`
	if err := database.DB.Exec(insertQuery, requesterID, addresseeID).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "failed to send friend request"})
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

type FriendshipStatusResponse struct {
	Status string `json:"status"`
}

func GetFriendshipStatusHandler(c fiber.Ctx) error {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized"})
	}

	var target struct {
		ID uuid.UUID
	}
	if err := database.DB.Table("users").Select("id").Where("username = ?", c.Params("username")).First(&target).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "user not found in db"})
	}

	if target.ID == userID {
		return c.JSON(FriendshipStatusResponse{Status: "self"})
	}

	var relation struct {
		RequesterID uuid.UUID
		Status      string
	}
	result := database.DB.Table("friendships").
		Select("requester_id, status").
		Where("(requester_id = ? AND addressee_id = ?) OR (requester_id = ? AND addressee_id = ?)", userID, target.ID, target.ID, userID).
		Limit(1).
		Scan(&relation)
	if result.Error != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "database error"})
	}
	if result.RowsAffected == 0 {
		return c.JSON(FriendshipStatusResponse{Status: "none"})
	}
	if relation.Status == "accepted" {
		return c.JSON(FriendshipStatusResponse{Status: "accepted"})
	}
	if relation.RequesterID == userID {
		return c.JSON(FriendshipStatusResponse{Status: "pending_sent"})
	}

	return c.JSON(FriendshipStatusResponse{Status: "pending_received"})
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

func GetUserFriendsHandler(c fiber.Ctx) error {
	var target struct {
		ID uuid.UUID
	}

	err := database.DB.Table("users").Select("id").Where("username = ?", c.Params("username")).First(&target).Error
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "user not found in db"})
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
	if err := database.DB.Raw(query, target.ID, target.ID, target.ID).Scan(&friends).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "database erroor"})
	}

	if friends == nil {
		friends = []UserResponse{}
	}
	return c.Status(fiber.StatusOK).JSON(friends)
}

func RemoveFriendHandler(c fiber.Ctx) error {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized"})
	}

	targetUsername := c.Params("username")
	if targetUsername == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "target username is required"})
	}

	var targetUser struct {
		ID uuid.UUID
	}
	if err := database.DB.Table("users").Select("id").Where("username = ?", targetUsername).First(&targetUser).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "target user not found in db"})
	}
	targetID := targetUser.ID

	deleteQuery := `DELETE FROM friendships WHERE (requester_id = ? AND addressee_id = ?) OR (requester_id = ? AND addressee_id = ?)`
	result := database.DB.Exec(deleteQuery, userID, targetID, targetID, userID)

	if result.Error != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "database error during remval"})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "friendship or request removed succcessfully",
	})
}
