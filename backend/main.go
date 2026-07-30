package main

import (
	"github.com/JeeNeeUhs/ft_transcendence/auth"
	"github.com/JeeNeeUhs/ft_transcendence/room"
	"github.com/gofiber/fiber/v3"
)

func main() {
	app := fiber.New()
	api := app.Group("/api")

	room.Register(api)
	auth.Register(api)

	app.Listen(":8081")

}
