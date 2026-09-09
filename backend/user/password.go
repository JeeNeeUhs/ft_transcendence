package user

import (
	"strings"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/JeeNeeUhs/ft_transcendence/token"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

type UpdatePasswordRequest struct {
	CurrentPassword string `json:"current_password"`
	NewPassword     string `json:"new_password"`
}

func UpdatePasswordHandler(c fiber.Ctx) error {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(apierr.CodeToStatus(13)).JSON(apierr.CodeToErr(13))
	}

	var req UpdatePasswordRequest
	if err := c.Bind().Body(&req); err != nil {
		return c.Status(apierr.CodeToStatus(1)).JSON(apierr.CodeToErr(1))
	}

	req.NewPassword = strings.TrimSpace(req.NewPassword)
	if len(req.NewPassword) < 8 || len(req.NewPassword) > 50 {
		return c.Status(apierr.CodeToStatus(7)).JSON(apierr.CodeToErr(7))
	}

	var user models.User
	if err := database.DB.First(&user, "id = ?", userID).Error; err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}

	if user.PasswordHash == "" {
		return c.Status(apierr.CodeToStatus(49)).JSON(apierr.CodeToErr(49))
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte(strings.TrimSpace(req.CurrentPassword))); err != nil {
		return c.Status(apierr.CodeToStatus(48)).JSON(apierr.CodeToErr(48))
	}

	hash, err := bcrypt.GenerateFromPassword([]byte(req.NewPassword), bcrypt.DefaultCost)
	if err != nil {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	if err := database.DB.Model(&user).Update("password_hash", string(hash)).Error; err != nil {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	token.Logout(userID)
	tokenVersion := token.Login(userID)
	accessToken, err := token.GenerateAccessToken(userID, tokenVersion)
	if err != nil {
		return c.Status(apierr.CodeToStatus(4)).JSON(apierr.CodeToErr(4))
	}

	return c.JSON(fiber.Map{"access_token": accessToken})
}
