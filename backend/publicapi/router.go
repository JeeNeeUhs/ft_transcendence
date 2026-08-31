package publicapi

import (
	"github.com/JeeNeeUhs/ft_transcendence/apikey"
	_ "github.com/JeeNeeUhs/ft_transcendence/docs"
	"github.com/gofiber/contrib/v3/swaggo"
	"github.com/gofiber/fiber/v3"
)

func Register(api fiber.Router) {
	publicGroup := api.Group("/public")

	publicGroup.Get("/docs/*", swaggo.HandlerDefault)

	protected := publicGroup.Group("/", apikey.APIKeyAuth, apikey.RateLimiter())

	protected.Get("/stats/users", GetUserStatsHandler)
	protected.Get("/stats/matches", GetMatchStatsHandler)
}