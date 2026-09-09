package apikey

import (
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/gofiber/fiber/v3"
)

func Register(api fiber.Router) {
	apikeyGroup := api.Group("/apikey", middleware.UpdateStatus)
	

	apikeyGroup.Get("/", middleware.RequireAuth, HandleGetKey)
	apikeyGroup.Post("/", middleware.RequireAuth, HandleCreateKey)
	apikeyGroup.Delete("/", middleware.RequireAuth, HandleDeleteKey)
}