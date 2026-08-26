package room

import (
	"errors"
	"math/rand/v2"

	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/models"
)

var questionPlan = []struct {
	difficulty string
	count      int
}{
	{"Easy", 5},
	{"Medium", 2},
	{"Hard", 2},
	{"Very Hard", 1},
}

var questionsPerGame = func() int {
	total := 0
	for _, step := range questionPlan {
		total += step.count
	}
	return total
}()

var errNoCategories = errors.New("room: no categories to draw questions from")

func pickQuestionIDs(categoryIDs []int, lang string) ([]int, error) {
	if len(categoryIDs) == 0 {
		return nil, errNoCategories
	}

	picked := make([]int, 0, questionsPerGame)
	for _, step := range questionPlan {
		var batch []int
		err := database.DB.
			Model(&models.Question{}).
			Where("category_id IN ? AND difficulty = ? AND language = ?", categoryIDs, step.difficulty, lang).
			Order("RANDOM()").
			Limit(step.count).
			Pluck("id", &batch).Error
		if err != nil {
			return nil, err
		}
		picked = append(picked, batch...)
	}

	rand.Shuffle(len(picked), func(i, j int) {
		picked[i], picked[j] = picked[j], picked[i]
	})

	return picked, nil
}

var (
	pickQuestionIDsFn = pickQuestionIDs
	fetchQuestionFn   = fetchQuestion
)

func fetchQuestion(id int) (models.Question, error) {
	var q models.Question
	if err := database.DB.First(&q, "id = ?", id).Error; err != nil {
		return models.Question{}, err
	}
	return q, nil
}
