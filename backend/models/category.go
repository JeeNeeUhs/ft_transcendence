package models

type Category struct {
	ID   int    `gorm:"column:id;primaryKey" json:"id"`
	Name string `gorm:"column:name;type:varchar(50);unique;not null" json:"name"`
}

func (Category) TableName() string {
	return "categories"
}
