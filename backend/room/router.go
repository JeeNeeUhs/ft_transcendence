package room

import (
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/gofiber/fiber/v3"
)

func Register(api fiber.Router) {
	room := api.Group("/room")
	room.Post("/create", middleware.RequireAuth, createRoomHandler)
	room.Post("/join", middleware.RequireAuth, joinRoomHandler)
	room.Post("/leave", middleware.RequireAuth, leaveRoomHandler)
	room.Get("/search", middleware.RequireAuth, searchRoomsHandler)
	room.Get("/exist", middleware.RequireAuth, existRoomHandler)
	room.Get("/categories", middleware.RequireAuth, listCategoriesHandler)
}
