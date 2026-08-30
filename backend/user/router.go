package user

import (
	"github.com/JeeNeeUhs/ft_transcendence/config"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/gofiber/fiber/v3"
	"github.com/gofiber/fiber/v3/middleware/static"
)

func Register(api fiber.Router) {
	user := api.Group("/user")

	user.Get("/me", middleware.RequireAuth, MeHandler)
	user.Patch("/me", middleware.RequireAuth, UpdateMeHandler)
	user.Put("/me/password", middleware.RequireAuth, UpdatePasswordHandler)
	user.Post("/avatar", middleware.RequireAuth, UploadAvatarHandler)
	user.Get("/avatars/*", static.New(config.AvatarDir))
	user.Get("/:username", middleware.RequireAuth, ProfileHandler)
}
