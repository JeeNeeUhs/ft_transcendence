package publicapi

import (
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/gofiber/fiber/v3"
)

func DocsHandler(c fiber.Ctx) error {
	docs := fiber.Map{
		"version": "1.0",
		"description": "ft_transcendence Public API Documentation",
		"base_url": "/api/public",
		"headers_required": fiber.Map{
			"X-API-Key": "Your unique API key must be provided in the headers",
		},
		"rate_limit": "1200 requests per hour per key",
		"endpoints": []fiber.Map{
			{
				"path": "/stats/users",
				"method": "GET",
				"description": "Returns general statistics about users (total, intra, 2FA)",
			},
			{
				"path": "/stats/matches",
				"method": "GET",
				"description": "Returns total matches played on the platform",
			},
			{
				"path": "/feedback",
				"method": "POST",
				"description": "Submit a feedback or custom stat report to the developers",
			},
			{
				"path": "/feedback/:id",
				"method": "PUT",
				"description": "Update a previously submitted feedback",
			},
			{
				"path": "/feedback/:id",
				"method": "DELETE",
				"description": "Delete a previously submitted feedback",
			},
		},
	}
	return c.JSON(docs)
}


func GetUserStatsHandler(c fiber.Ctx) error {
	var totalUsers, intraUsers, twoFaUsers int64
	
	database.DB.Table("users").Count(&totalUsers)
	database.DB.Table("users").Where("is_intra = ?", true).Count(&intraUsers)
	database.DB.Table("users").Where("is_2fa_enabled = ?", true).Count(&twoFaUsers)

	return c.JSON(fiber.Map{
		"total_users": totalUsers,
		"intra_users": intraUsers,
		"two_fa_users": twoFaUsers,
	})
}

func GetMatchStatsHandler(c fiber.Ctx) error {
	var totalMatches int64
	database.DB.Table("matches").Count(&totalMatches)
	return c.JSON(fiber.Map{"total_matches": totalMatches})
}

