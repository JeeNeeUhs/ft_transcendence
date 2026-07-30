package config

import "os"

var (
	ApiURL       string = getEnv("API_URL", "http://localhost:8081")
	RedirectURI  string = getEnv("REDIRECT_URI", "http://localhost:8080/auth/42/callback")
	ClientID     string = getEnv("CLIENT_ID", "")
	ClientSecret string = getEnv("CLIENT_SECRET", "")
)

func getEnv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
