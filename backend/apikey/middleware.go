package apikey

import (
	"time"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/gofiber/fiber/v3"
	"github.com/gofiber/fiber/v3/middleware/limiter"
)

func APIKeyAuth(c fiber.Ctx) error {

	apiKey := c.Get("X-API-Key")
	if apiKey == "" {
		return c.Status(apierr.CodeToStatus(41)).JSON(apierr.CodeToErr(41))
	}

	var ownerID string

	err := database.DB.Raw("SELECT owner_id FROM api_keys WHERE key = ? AND is_active = true", apiKey).Scan(&ownerID).Error
	if err != nil || ownerID == "" {
		return c.Status(apierr.CodeToStatus(41)).JSON(apierr.CodeToErr(41))
	}

	c.Locals("api_owner_id", ownerID)

	return c.Next()
}

func RateLimiter() fiber.Handler {
	return limiter.New(limiter.Config{
		Max:        1200,
		Expiration: 1 * time.Hour,
		KeyGenerator: func(c fiber.Ctx) string {
			return c.Get("X-API-Key")
		},
		LimitReached: func(c fiber.Ctx) error {
			return c.Status(apierr.CodeToStatus(40)).JSON(apierr.CodeToErr(40))
		},
	})
}
