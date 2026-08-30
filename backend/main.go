package main

import (
	"log"

	"github.com/JeeNeeUhs/ft_transcendence/auth"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/JeeNeeUhs/ft_transcendence/room"
	"github.com/JeeNeeUhs/ft_transcendence/user"
	"github.com/JeeNeeUhs/ft_transcendence/apikey"
	"github.com/gofiber/fiber/v3"
	"github.com/JeeNeeUhs/ft_transcendence/publicapi"
)

// @title ft_transcendence Public API
// @version 1.0
// @description Public API statistics endpoints for the ft_transcendence project.
// @host localhost:8081
// @BasePath /
// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name X-API-Key

func main() {

	if err := database.Connect(); err != nil {
		log.Fatal(err)
	}

	app := fiber.New(fiber.Config{BodyLimit: user.MaxAvatarSize + 1024*1024})
	app.Use(middleware.CORS())
	api := app.Group("/api")

	room.Register(api)
	auth.Register(api)
	user.Register(api)
	apikey.Register(api)
	publicapi.Register(api)

	app.Listen(":8081")

}
