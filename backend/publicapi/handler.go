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



type FriendRequestInput struct {
	Username string `json:"username"`
}


// GetFriendsHandler godoc
// @Summary List friends
// @Tags Public Friends
// @Security ApiKeyAuth
// @Produce json
// @Success 200 {array} map[string]interface{}
// @Router /api/public/me/friends [get]
func GetFriendsHandler(c fiber.Ctx) error {
	ownerID, ok := c.Locals("api_owner_id").(string)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized api key"})
	}

	var friends []map[string]interface{}
	query := `
		SELECT u.username, u.avatar_url, u.status
		FROM users u
		INNER JOIN friendships f ON (u.id = f.requester_id OR u.id = f.addressee_id)
		WHERE (f.requester_id = ? OR f.addressee_id = ?)
			AND f.status = 'accepted'
			AND u.id != ?
	`
	if err := database.DB.Raw(query, ownerID, ownerID, ownerID).Scan(&friends).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "database error"})
	}

	if friends == nil {
		friends = []map[string]interface{}{}
	}

	return c.JSON(friends)
}

// SendFriendRequestHandler godoc
// @Summary Send friend request
// @Tags Public Friends
// @Security ApiKeyAuth
// @Accept json
// @Produce json
// @Param request body FriendRequestInput true "Target Username"
// @Success 200 {object} map[string]interface{}
// @router /api/public/me/friend-requests [post]
func SendFriendRequestHandler(c fiber.Ctx) error {

	ownerID, ok := c.Locals("api_owner_id").(string)
	if !ok{
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized api key"})
	}

	var input FriendRequestInput
	if err := c.Bind().Body(&input); err != nil || input.Username == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}

	var targetUser struct{ ID string }
	if err := database.DB.Table("users").Select("id").Where("username = ?", input.Username).First(&targetUser).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "target user not found"})
	}

	if ownerID == targetUser.ID {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "cannot send requestto yourself"})
	}

	insertQuery := `INSERT INTO friendships (requester_id, addressee_id, status) VALUES (?, ?, 'pending')`
	if err := database.DB.Exec(insertQuery, ownerID, targetUser.ID).Error; err != nil {
		return c.Status(fiber.StatusConflict).JSON(fiber.Map{"error": "request already exists or database error"})
	}

	return c.JSON(fiber.Map{"message": "friend request send"})
}

// AcceptFriendRequestHandler godoc
// @Summary Accept friend request
// @Tags Public Friends
// @Security ApiKeyAuth
// @Produce json
// @Param username path string true "Requester Username"
// @Success 200 {object} map[string]interface{}
// @Router /api/public/me/friend-requests/{username} [put]
func AcceptFriendRequestHandler(c fiber.Ctx) error {
	ownerID, ok := c.Locals("api_owner_id").(string)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized api key"})
	}

	targetUsername := c.Params("username")
	var reqUser struct{ ID string }
	if err := database.DB.Table("users").Select("id").Where("username = ?", targetUsername).First(&reqUser).Error; err !=nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "requester not found"})
	}

	updateQuery := `UPDATE friendships SET status = 'accepted' WHERE requester_id = ? AND addressee_id = ? AND status = 'pending'`
	result := database.DB.Exec(updateQuery, reqUser.ID, ownerID)
	

	if result.RowsAffected == 0 {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "no pending request found from this user"})
	}

	return c.JSON(fiber.Map{"message": "friend request accepted"})

}

// DeleteFriendshipHandler godoc
// @Summary Delete friend or cancel request
// @Tags Public Friends
// @Security ApiKeyAuth
// @Produce json
// @Param username path string true "Target Username"
// @Success 200 {object} map[string]interface{}
// @Router /api/public/me/friendships/{username} [delete]
func DeleteFriendshipHandler(c fiber.Ctx) error {
	ownerID, ok := c.Locals("api_owner_id").(string)
	if !ok {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "unauthorized ai key"})
	}

	targetUsername := c.Params("username")
	var targetUser struct { ID string }
	if err := database.DB.Table("users").Select("id").Where("username = ?", targetUsername).First(&targetUser).Error;  err!= nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "target user not found"})
	}

	deleteQuery := `DELETE FROM friendships WHERE (requester_id = ? AND addressee_id = ?) OR (requester_id = ? AND addressee_id = ?)`
	database.DB.Exec(deleteQuery, ownerID, targetUser.ID, targetUser.ID, ownerID)

	return c.JSON(fiber.Map{"message": "friendships or request removed"})
}

