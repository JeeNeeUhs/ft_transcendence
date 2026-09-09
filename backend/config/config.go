package config

import (
	"os"
	"strings"
)

var (
	AppOrigin    string = strings.TrimRight(getEnv("APP_ORIGIN", "https://localhost:8081"), "/")
	ApiURL       string = getEnv("API_URL", AppOrigin)
	RedirectURI  string = getEnv("REDIRECT_URI", AppOrigin+"/oauth/intra/callback")
	ClientID     string = getEnv("CLIENT_ID", "")
	ClientSecret string = getEnv("CLIENT_SECRET", "")
	JwtSecret    string = getEnv("JWT_SECRET", "default_jwt_secret")
	AvatarDir    string = getEnv("AVATAR_DIR", "./avatars")

	CorsAllowedOrigins []string = strings.Split(getEnv("CORS_ALLOWED_ORIGINS", AppOrigin), ",")

	DBHost     string = getEnv("DB_HOST", "database")
	DBPort     string = getEnv("DB_PORT", "5432")
	DBUser     string = getEnv("POSTGRES_USER", "postgres")
	DBPassword string = getEnv("POSTGRES_PASSWORD", "")
	DBName     string = getEnv("POSTGRES_DB", "transcendence")
	DBSSLMode  string = getEnv("DB_SSLMODE", "disable")
)

func getEnv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
