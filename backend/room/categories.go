package room

import (
	"strings"

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
		return false, nil
	}

	var count int64
	if err := database.DB.Model(&models.Category{}).Where("id IN ?", ids).Count(&count).Error; err != nil {
		return false, err
	}

	return int(count) == len(ids), nil
}

var categoryNameColumns = map[string]string{
	"tr": "name_tr",
	"en": "name_en",
	"es": "name_es",
}

type categoryView struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

func listCategoriesHandler(c fiber.Ctx) error {
	lang := strings.ToLower(strings.TrimSpace(c.Query("lang")))

	nameColumn, ok := categoryNameColumns[lang]
	if !ok {
		return c.Status(apierr.CodeToStatus(34)).JSON(apierr.CodeToErr(34))
	}

	var categories []categoryView
	if err := database.DB.
		Model(&models.Category{}).
		Select("id", nameColumn+" AS name").
		Order("id").
		Scan(&categories).Error; err != nil {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	return c.JSON(fiber.Map{"categories": categories})
}
