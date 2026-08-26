package room

import (
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/gofiber/fiber/v3"
)

func Register(api fiber.Router) {
	room := api.Group("/room")
	room.Get("/create", middleware.RequireAuth, createRoomHandler)
	room.Get("/join", middleware.RequireAuth, joinRoomHandler)
	room.Get("/list", listRoomsHandler)
	room.Get("/exist", middleware.RequireAuth, existRoomHandler)
	room.Get("/categories", listCategoriesHandler)
}
