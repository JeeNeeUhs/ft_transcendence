package models

type Question struct {
	ID            int    `gorm:"column:id;primaryKey" json:"id"`
	CategoryID    int    `gorm:"column:category_id" json:"category_id"`
	QuestionText  string `gorm:"column:question_text" json:"question_text"`
	OptionA       string `gorm:"column:option_a" json:"option_a"`
	OptionB       string `gorm:"column:option_b" json:"option_b"`
	OptionC       string `gorm:"column:option_c" json:"option_c"`
	OptionD       string `gorm:"column:option_d" json:"option_d"`
	CorrectOption string `gorm:"column:correct_option" json:"-"`
	Difficulty    string `gorm:"column:difficulty" json:"difficulty"`
	Language      string `gorm:"column:language" json:"language"`
}

func (Question) TableName() string {
	return "questions"
}
