package room

import "github.com/gofiber/fiber/v3"

func createRoom(c fiber.Ctx) error {
	return c.SendString("Room created")
}

func joinRoom(c fiber.Ctx) error {
	return c.SendString("Joined room")
}
