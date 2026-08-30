package models

import (
	"time"

	"github.com/google/uuid"
)

type User struct {
	ID              uuid.UUID `gorm:"type:uuid;primaryKey;default:uuid_generate_v4()" json:"id"`
	Username        string    `gorm:"column:username;type:varchar(50);unique;not null" json:"username"`
	PasswordHash    string    `gorm:"column:password_hash;not null" json:"-"`
	AvatarURL       string    `gorm:"column:avatar_url" json:"avatar_url,omitempty"`
	Description     string    `gorm:"column:description;type:varchar(100)" json:"description,omitempty"`
	IsIntra         bool      `gorm:"column:is_intra;default:false" json:"is_intra"`
	IntraID         string    `gorm:"column:intra_id;type:varchar(15)" json:"intra_id,omitempty"`
	Is2FAEnabled    bool      `gorm:"column:is_2fa_enabled;default:false" json:"is_2fa_enabled"`
	TwoFactorSecret string    `gorm:"column:two_factor_secret" json:"-"`
	Status          string    `gorm:"column:status;type:varchar(20);default:offline" json:"status"`
	CreatedAt       time.Time `gorm:"column:created_at;default:now()" json:"created_at"`
}

func (User) TableName() string {
	return "users"
}
