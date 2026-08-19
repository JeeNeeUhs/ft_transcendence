package room

import (
	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/gofiber/fiber/v3"
)

func hasDuplicateInts(ids []int) bool {
	seen := make(map[int]struct{}, len(ids))
	for _, id := range ids {
		if _, ok := seen[id]; ok {
			return true
		}
		seen[id] = struct{}{}
	}
	return false
}

func checkCategoryIDs(ids []int) (bool, error) {
	if len(ids) == 0 {
		return true, nil
	}

	var count int64
	if err := database.DB.Model(&models.Category{}).Where("id IN ?", ids).Count(&count).Error; err != nil {
		return false, err
	}

	return int(count) == len(ids), nil
}

func listCategoriesHandler(c fiber.Ctx) error {
	var categories []models.Category
	if err := database.DB.Find(&categories).Error; err != nil {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	return c.JSON(fiber.Map{"categories": categories})
}
