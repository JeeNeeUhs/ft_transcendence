package main

import (
	"log"

	"github.com/JeeNeeUhs/ft_transcendence/apikey"
	"github.com/JeeNeeUhs/ft_transcendence/auth"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/friend"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/JeeNeeUhs/ft_transcendence/publicapi"
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
	apikey.Register(api)
	publicapi.Register(api)
	friend.Register(api)

	app.Listen(":8081")

}
