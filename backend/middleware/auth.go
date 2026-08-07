package middleware

import (
	"strings"

	"github.com/JeeNeeUhs/ft_transcendence/token"
	"github.com/gofiber/fiber/v3"
)

const LocalsUserIDKey = "userID"

func RequireAuth(c fiber.Ctx) error {
	authHeader := c.Get("Authorization")
	if authHeader == "" {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "missing authorization header"})
	}

	parts := strings.SplitN(authHeader, " ", 2)
	if len(parts) != 2 || !strings.EqualFold(parts[0], "Bearer") {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "invalid authorization header"})
	}

	claims, err := token.ParseAccessToken(parts[1])
	if err != nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "invalid or expired token"})
	}

	if !token.IsValid(claims.UserID, claims.TokenVersion) {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "token has been invalidated"})
	}

	c.Locals(LocalsUserIDKey, claims.UserID)

	return c.Next()
}
