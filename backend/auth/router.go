package auth

import (
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/gofiber/fiber/v3"
)

func Register(api fiber.Router) {
	auth := api.Group("/auth")
	auth.Get("/42/login", Login42Handler)
	auth.Post("/42/callback", CallbackHandler)
	auth.Post("/42/register", Register42Handler)

	auth.Post("/register", RegisterHandler)
	auth.Post("/login", LoginHandler)
	auth.Post("/logout", middleware.RequireAuth, LogoutHandler)

	auth.Get("/me", middleware.RequireAuth, MeHandler)
}
