package apikey

import (
	"crypto/rand"
	"encoding/hex"
	"time"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
)


func generateAPIKey() (string, error) {
	bytes := make([]byte, 32)
	if _, err := rand.Read(bytes); err != nil {
		return "", err
	}
	return "tk_" + hex.EncodeToString(bytes), nil
}


func HandleCreateKey(c fiber.Ctx) error {
	
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		
		return c.Status(apierr.CodeToStatus(13)).JSON(apierr.CodeToErr(13))
	}

	var existingKey string

	
	err := database.DB.Raw("SELECT key FROM api_keys WHERE owner_id = ?", userID).Scan(&existingKey).Error
	if err == nil && existingKey != "" {
	
		return c.Status(fiber.StatusOK).JSON(fiber.Map{
			"message": "Key retrieved",
			"key":     existingKey,
		})
	}

	
	newKey, err := generateAPIKey()
	if err != nil {
		
		return c.Status(apierr.CodeToStatus(0)).JSON(apierr.CodeToErr(0))
	}

	
	if err := database.DB.Exec("INSERT INTO api_keys (key, owner_id) VALUES (?, ?)", newKey, userID).Error; err != nil {
		
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	return c.Status(fiber.StatusCreated).JSON(fiber.Map{
		"message": "Key created",
		"key":     newKey,
	})
}


type APIKeyView struct {
	Key       string    `json:"key"`
	IsActive  bool      `json:"is_active"`
	CreatedAt time.Time `json:"created_at"`
}

func HandleGetKey(c fiber.Ctx) error {

	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {

		return c.Status(apierr.CodeToStatus(13)).JSON(apierr.CodeToErr(13))
	}

	var keys []APIKeyView

	if err := database.DB.Raw("SELECT key, is_active, created_at FROM api_keys WHERE owner_id = ?", userID).Scan(&keys).Error; err != nil {

		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	if len(keys) == 0 {

		return c.Status(apierr.CodeToStatus(50)).JSON(apierr.CodeToErr(50))
	}

	return c.JSON(keys[0])
}

func HandleDeleteKey(c fiber.Ctx) error {
	
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		
		return c.Status(apierr.CodeToStatus(13)).JSON(apierr.CodeToErr(13))
	}

	
	if err := database.DB.Exec("DELETE FROM api_keys WHERE owner_id = ?", userID).Error; err != nil {
		
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "API key deleted successfully",
	})
}