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

// SendRequestHandler godoc
// @Summary Send friend request
// @Tags Friends
// @Accept json
// @Produce json
// @Param request body SendRequestInput true "Target User Name"
// @Success 201 {object} map[string]interface{}
// @Router /api/friend/request [post]
func SendRequestHandler(c fiber.Ctx) error {
	
	requesterID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized"})
	}

	
	var input SendRequestInput
	if err := c.Bind().Body(&input); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}

	
	var addresseeID uuid.UUID
	err := database.DB.Table("users").Select("id").Where("username = ?", input.AddresseeUsername).Scan(&addresseeID).Error
	if err != nil || addresseeID == uuid.Nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "user not found"})
	}

	
	insertQuery := `INSERT INTO friendships (requester_id, addressee_id, status) VALUES (?, ?, 'pending')`
	if err := database.DB.Exec(insertQuery, requesterID, addresseeID).Error; err != nil {
		return c.Status(fiber.StatusConflict).JSON(fiber.Map{"error": "friend request already exists or invalid"})
	}

	return c.Status(fiber.StatusCreated).JSON(fiber.Map{
		"message": "friend request sent successfully",
	})
}