package publicapi

import (
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/gofiber/fiber/v3"
)

// GetUserStatsHandler godoc
// @Summary Get user statistics
// @Description Returns the total number of users, 42 Intra users, and users with 2FA enabled.
// @Tags Public Stats
// @Security ApiKeyAuth
// @Produce json
// @Success 200 {object} map[string]interface{}
// @Router /api/public/stats/users [get]
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


// GetMatchStatsHandler godoc
// @Summary Get match statistics
// @Description Returns the total number of matches played on the platform.
// @Tags Public Stats
// @Security ApiKeyAuth
// @Produce json
// @Success 200 {object} map[string]interface{}
// @Router /api/public/stats/matches [get]
func GetMatchStatsHandler(c fiber.Ctx) error {
	var totalMatches int64
	database.DB.Table("matches").Count(&totalMatches)
	return c.JSON(fiber.Map{"total_matches": totalMatches})
}

