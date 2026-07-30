package auth

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"strings"

	"github.com/JeeNeeUhs/ft_transcendence/config"
	"github.com/gofiber/fiber/v3"
)

func fromCodeGetToken(code string) (map[string]interface{}, error) {
	apiURL := "https://api.intra.42.fr/oauth/token"

	payload := url.Values{}
	payload.Set("grant_type", "authorization_code")
	payload.Set("client_id", config.ClientID)
	payload.Set("client_secret", config.ClientSecret)
	payload.Set("code", code)
	payload.Set("redirect_uri", config.RedirectURI)

	req, err := http.NewRequest("POST", apiURL, strings.NewReader(payload.Encode()))
	if err != nil {
		return nil, err
	}

	client := &http.Client{}
	res, err := client.Do(req)
	if err != nil {
		return nil, err
	}
	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)
	if err != nil {
		return nil, err
	}

	var result map[string]interface{}
	if err := json.Unmarshal(body, &result); err != nil {
		return nil, err
	}

	return result, nil
}

func LoginHandler(c fiber.Ctx) error {
	authURL := fmt.Sprintf("https://api.intra.42.fr/oauth/authorize?client_id=%s&redirect_uri=%s&response_type=code", config.ClientID, url.QueryEscape(config.RedirectURI))

	return c.JSON(fiber.Map{
		"url": authURL,
	})
}

func CallbackHandler(c fiber.Ctx) error {
	code := c.Query("code")
	if code == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "No code provided"})
	}

	token, err := fromCodeGetToken(code)
	if err != nil {
		fmt.Println(err)
		return c.Status(fiber.StatusInternalServerError).JSON(err)
	}

	return c.JSON(token)
}

func AuthHandler(c fiber.Ctx) error {
	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Authenticated"})
}
