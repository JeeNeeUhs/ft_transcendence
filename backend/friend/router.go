package friend

import (
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/gofiber/fiber/v3"
)

func Register(api fiber.Router) {
	
	friendGroup := api.Group("/friend", middleware.RequireAuth)
	

	friendGroup.Post("/request", SendRequestHandler)
	friendGroup.Post("/accept", AcceptRequestHandler)
	friendGroup.Get("/requests", GetRequestsHandler)
	friendGroup.Get("/list", GetFriendsHandler)
}