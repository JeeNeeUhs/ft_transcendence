package user

import (
	"errors"
	"strings"
	"unicode/utf8"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

func MeHandler(c fiber.Ctx) error {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(apierr.CodeToStatus(13)).JSON(apierr.CodeToErr(13))
	}

	var user models.User
	if err := database.DB.First(&user, "id = ?", userID).Error; err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}

	return c.JSON(fiber.Map{
		"username":    user.Username,
		"avatar_url":  user.AvatarURL,
		"description": user.Description,
		"is_intra":    user.IsIntra,
		"status":      user.Status,
		"created_at":  user.CreatedAt,
	})
}

const maxDescriptionLength = 100

type UpdateMeRequest struct {
	Description *string `json:"description"`
}

func UpdateMeHandler(c fiber.Ctx) error {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(apierr.CodeToStatus(13)).JSON(apierr.CodeToErr(13))
	}

	var req UpdateMeRequest
	if err := c.Bind().Body(&req); err != nil {
		return c.Status(apierr.CodeToStatus(1)).JSON(apierr.CodeToErr(1))
	}
	if req.Description == nil {
		return c.Status(apierr.CodeToStatus(1)).JSON(apierr.CodeToErr(1))
	}

	description := strings.TrimSpace(*req.Description)
	if utf8.RuneCountInString(description) > maxDescriptionLength {
		return c.Status(apierr.CodeToStatus(47)).JSON(apierr.CodeToErr(47))
	}

	var user models.User
	if err := database.DB.First(&user, "id = ?", userID).Error; err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}

	if err := database.DB.Model(&user).Update("description", description).Error; err != nil {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	return c.JSON(fiber.Map{"description": description})
}

func ProfileHandler(c fiber.Ctx) error {
	username := c.Params("username")

	var user models.User
	err := database.DB.Where("username = ?", username).First(&user).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return c.Status(apierr.CodeToStatus(46)).JSON(apierr.CodeToErr(46))
	}
	if err != nil {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	return c.JSON(fiber.Map{
		"username":    user.Username,
		"avatar_url":  user.AvatarURL,
		"description": user.Description,
		"status":      user.Status,
		"created_at":  user.CreatedAt,
	})
}
