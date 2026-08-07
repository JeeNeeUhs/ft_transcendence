package database

import (
	"fmt"
	"log"

	"github.com/JeeNeeUhs/ft_transcendence/config"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

var DB *gorm.DB

func Connect() error {
	dsn := fmt.Sprintf(
		"host=%s port=%s user=%s password=%s dbname=%s sslmode=%s",
		config.DBHost, config.DBPort, config.DBUser, config.DBPassword, config.DBName, config.DBSSLMode,
	)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Warn),
	})
	if err != nil {
		return fmt.Errorf("failed to connect to database: %w", err)
	}

	if err := db.AutoMigrate(&models.User{}); err != nil {
		return fmt.Errorf("failed to migrate users table: %w", err)
	}

	DB = db
	log.Println("Database connection established")
	return nil
}
