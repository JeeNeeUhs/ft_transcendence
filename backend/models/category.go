package models

type Category struct {
	ID     int    `gorm:"column:id;primaryKey" json:"id"`
	NameTR string `gorm:"column:name_tr" json:"name_tr"`
	NameEN string `gorm:"column:name_en" json:"name_en"`
	NameES string `gorm:"column:name_es" json:"name_es"`
}

func (Category) TableName() string {
	return "categories"
}
