package main

import (
	"log"

	"github.com/JeeNeeUhs/ft_transcendence/auth"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/JeeNeeUhs/ft_transcendence/room"
	"github.com/gofiber/fiber/v3"
)

func main() {
	if err := database.Connect(); err != nil {
		log.Fatal(err)
	}

	app := fiber.New()
	api := app.Group("/api")
	api.Use(middleware.CORS())

	room.Register(api)
	auth.Register(api)

	app.Listen(":8081")

}
