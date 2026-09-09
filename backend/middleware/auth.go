package middleware

import (
	"strings"
	"time"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/JeeNeeUhs/ft_transcendence/token"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
)

const LocalsUserIDKey = "userID"

func RequireAuth(c fiber.Ctx) error {
	authHeader := c.Get("Authorization")
	if authHeader == "" {
		return c.Status(apierr.CodeToStatus(14)).JSON(apierr.CodeToErr(14))
	}

	parts := strings.SplitN(authHeader, " ", 2)
	if len(parts) != 2 || !strings.EqualFold(parts[0], "Bearer") {
		return c.Status(apierr.CodeToStatus(15)).JSON(apierr.CodeToErr(15))
	}

	claims, err := token.ParseAccessToken(parts[1])
	if err != nil {
		return c.Status(apierr.CodeToStatus(16)).JSON(apierr.CodeToErr(16))
	}

	if !token.IsValid(claims.UserID, claims.TokenVersion) {
		return c.Status(apierr.CodeToStatus(17)).JSON(apierr.CodeToErr(17))
	}

	c.Locals(LocalsUserIDKey, claims.UserID)

	return c.Next()
}

func UpdateStatus(c fiber.Ctx) error {
	parts := strings.SplitN(c.Get("Authorization"), " ", 2)
	if len(parts) == 2 && strings.EqualFold(parts[0], "Bearer") {
		if claims, err := token.ParseAccessToken(parts[1]); err == nil {
			if token.IsValid(claims.UserID, claims.TokenVersion) {
				setStatus(claims.UserID)
			}
		}
	}

	return c.Next()
}

func setStatus(userID uuid.UUID) {
	now := time.Now().Unix()

	go func() {
		database.DB.Model(&models.User{}).Where("id = ? AND status <> ?", userID, models.StatusOnline).Update("status", now)
	}()
}

func RequireAuthWS(c fiber.Ctx) error {
	authHeader := c.Get("Sec-WebSocket-Protocol")
	if authHeader == "" {
		return c.Status(apierr.CodeToStatus(14)).JSON(apierr.CodeToErr(14))
	}

	claims, err := token.ParseAccessToken(authHeader)
	if err != nil {
		return c.Status(apierr.CodeToStatus(16)).JSON(apierr.CodeToErr(16))
	}

	if !token.IsValid(claims.UserID, claims.TokenVersion) {
		return c.Status(apierr.CodeToStatus(17)).JSON(apierr.CodeToErr(17))
	}

	c.Locals(LocalsUserIDKey, claims.UserID)
	c.Set("Sec-WebSocket-Protocol", authHeader)

	return c.Next()
}
