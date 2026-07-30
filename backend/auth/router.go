package auth

import "github.com/gofiber/fiber/v3"

func Register(api fiber.Router) {
	auth := api.Group("/auth")
	auth.Get("/42/login", LoginHandler)
	auth.Get("/42/callback", CallbackHandler)
	auth.Get("/42/auth", AuthHandler)
}
