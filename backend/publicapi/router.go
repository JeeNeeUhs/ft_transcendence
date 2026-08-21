package publicapi

import (
	"github.com/JeeNeeUhs/ft_transcendence/apikey" 
	"github.com/gofiber/fiber/v3"
)


func Register(api fiber.Router) {
	publicGroup := api.Group("/public")

	publicGroup.Get("/docs", DocsHandler)


	protected := publicGroup.Group("/", apikey.APIKeyAuth, apikey.RateLimiter())


	protected.Get("/stats/users", GetUserStatsHandler)
	protected.Get("/stats/matches", GetMatchStatsHandler)
	protected.Post("/feedback", PostFeedbackHandler)
	protected.Put("/feedback/:id", PutFeedbackHandler)
	protected.Delete("/feedback/:id", DeleteFeedbackHandler)
}