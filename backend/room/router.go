package room

import "github.com/gofiber/fiber/v3"

func Register(api fiber.Router) {
	room := api.Group("/room")
	room.Get("/create", createRoom)
	room.Get("/join", joinRoom)
}
