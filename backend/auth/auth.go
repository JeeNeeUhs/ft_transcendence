package auth

import (
	"errors"
	"regexp"
	"strings"
	"time"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/JeeNeeUhs/ft_transcendence/token"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

var (
	validUsername = regexp.MustCompile(`^[A-Za-z0-9]{3,50}$`)
	validEmail    = regexp.MustCompile(`^[^@\s]+@[^@\s]+\.[^@\s]+$`)
)

const maxEmailLength = 255

func normalizeEmail(email string) string {
	return strings.ToLower(strings.TrimSpace(email))
}

type RegisterRequest struct {
	Username string `json:"username"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

func RegisterHandler(c fiber.Ctx) error {
	var req RegisterRequest
	if err := c.Bind().Body(&req); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}

	req.Username = strings.TrimSpace(req.Username)
	if !validUsername.MatchString(req.Username) {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "username not valid"})
	}

	req.Email = normalizeEmail(req.Email)
	if len(req.Email) > maxEmailLength || !validEmail.MatchString(req.Email) {
		return c.Status(apierr.CodeToStatus(51)).JSON(apierr.CodeToErr(51))
	}

	req.Password = strings.TrimSpace(req.Password)
	if len(req.Password) < 8 || len(req.Password) > 50 {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "password not valid"})
	}

	var existing models.User
	err := database.DB.Where("username = ?", req.Username).First(&existing).Error
	if err == nil {
		return c.Status(fiber.StatusConflict).JSON(fiber.Map{"error": "username already taken"})
	}
	if !errors.Is(err, gorm.ErrRecordNotFound) {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "internal server error"})
	}

	err = database.DB.Where("email = ?", req.Email).First(&existing).Error
	if err == nil {
		return c.Status(apierr.CodeToStatus(52)).JSON(apierr.CodeToErr(52))
	}
	if !errors.Is(err, gorm.ErrRecordNotFound) {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "internal server error"})
	}

	hash, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "internal server error"})
	}

	user := models.User{
		Username:     req.Username,
		Email:        req.Email,
		PasswordHash: string(hash),
		Status:       time.Now().Unix(),
	}
	if err := database.DB.Create(&user).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "failed to create user"})
	}

	tokenVersion := token.Login(user.ID)
	accessToken, err := token.GenerateAccessToken(user.ID, tokenVersion)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "failed to generate token"})
	}

	return c.Status(fiber.StatusCreated).JSON(fiber.Map{
		"access_token": accessToken,
	})
}

type LoginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func LoginHandler(c fiber.Ctx) error {
	var req LoginRequest
	if err := c.Bind().Body(&req); err != nil {
		return c.Status(apierr.CodeToStatus(1)).JSON(apierr.CodeToErr(1))
	}

	req.Username = strings.TrimSpace(req.Username)

	column, value := "username", req.Username
	if strings.Contains(req.Username, "@") {
		column, value = "email", normalizeEmail(req.Username)
	}

	var user models.User
	if err := database.DB.Where(column+" = ?", value).First(&user).Error; err != nil {
		return c.Status(apierr.CodeToStatus(12)).JSON(apierr.CodeToErr(12))
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte(req.Password)); err != nil {
		return c.Status(apierr.CodeToStatus(12)).JSON(apierr.CodeToErr(12))
	}

	database.DB.Model(&user).Where("status <> ?", models.StatusOnline).Update("status", time.Now().Unix())

	tokenVersion := token.Login(user.ID)
	accessToken, err := token.GenerateAccessToken(user.ID, tokenVersion)
	if err != nil {
		return c.Status(apierr.CodeToStatus(4)).JSON(apierr.CodeToErr(4))
	}

	return c.JSON(fiber.Map{
		"access_token": accessToken,
	})
}

func LogoutHandler(c fiber.Ctx) error {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(apierr.CodeToStatus(13)).JSON(apierr.CodeToErr(13))
	}

	token.Logout(userID)

	database.DB.Model(&models.User{}).Where("id = ?", userID).Update("status", 0)

	return c.JSON(fiber.Map{"message": "logged out"})
}
