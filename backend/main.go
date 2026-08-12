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
	app.Use(middleware.CORS())
	api := app.Group("/api")

	room.Register(api)
	auth.Register(api)

	app.Listen(":8081")

}
