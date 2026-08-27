package middleware

import (
	"strings"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/token"
	"github.com/gofiber/fiber/v3"
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

func RequireAuthWS(c fiber.Ctx) error {
	authHeader := c.Get("Sec-WebSocket-Protocol")
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
