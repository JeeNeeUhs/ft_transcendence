package publicapi

import (
	"net/url"

	"github.com/JeeNeeUhs/ft_transcendence/apikey"
	"github.com/JeeNeeUhs/ft_transcendence/config"
	"github.com/JeeNeeUhs/ft_transcendence/docs"
	"github.com/gofiber/contrib/v3/swaggo"
	"github.com/gofiber/fiber/v3"
)

func Register(api fiber.Router) {
	swaggerURL, _ := url.Parse(config.ApiURL)
	docs.SwaggerInfo.Host = swaggerURL.Host
	docs.SwaggerInfo.Schemes = []string{swaggerURL.Scheme}

	publicGroup := api.Group("/public")

	publicGroup.Get("/docs/*", swaggo.HandlerDefault)

	protected := publicGroup.Group("", apikey.APIKeyAuth, apikey.RateLimiter())

	protected.Get("/stats/users", GetUserStatsHandler)
	protected.Get("/stats/matches", GetMatchStatsHandler)

	protected.Get("/me/friends", GetFriendsHandler)
	protected.Post("/me/friend-requests", SendFriendRequestHandler)
	protected.Put("/me/friend-requests/:username", AcceptFriendRequestHandler)
	protected.Delete("/me/friendships/:username", DeleteFriendshipHandler)
}
