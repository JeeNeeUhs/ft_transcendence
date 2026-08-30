package auth

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"strings"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/config"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/JeeNeeUhs/ft_transcendence/token"
	"github.com/gofiber/fiber/v3"
	"gorm.io/gorm"
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

func fromTokenGetUserInfo(token string) (map[string]interface{}, error) {
	url := "https://api.intra.42.fr/v2/me"

	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, fmt.Errorf("fauiled to create request: %w", err)
	}
	req.Header.Set("Authorization", "Bearer "+token)

	client := &http.Client{}
	res, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("request failed: %w", err)
	}
	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response: %w", err)
	}

	var result map[string]interface{}
	if err := json.Unmarshal(body, &result); err != nil {
		return nil, fmt.Errorf("JSON parsing error: %w", err)
	}

	return result, nil
}

func Login42Handler(c fiber.Ctx) error {
	authURL := fmt.Sprintf("https://api.intra.42.fr/oauth/authorize?client_id=%s&redirect_uri=%s&response_type=code", config.ClientID, url.QueryEscape(config.RedirectURI))

	return c.JSON(fiber.Map{
		"url": authURL,
	})
}

func CallbackHandler(c fiber.Ctx) error {
	var data map[string]string
	if err := c.Bind().Body(&data); err != nil {
		return c.Status(apierr.CodeToStatus(1)).JSON(apierr.CodeToErr(1))
	}

	data["code"] = strings.TrimSpace(data["code"])
	if data["code"] == "" {
		return c.Status(apierr.CodeToStatus(2)).JSON(apierr.CodeToErr(2))
	}

	oauthtoken, err := fromCodeGetToken(data["code"])
	if err != nil || oauthtoken["access_token"] == nil {
		return c.Status(apierr.CodeToStatus(3)).JSON(apierr.CodeToErr(3))
	}

	userInfo, err := fromTokenGetUserInfo(oauthtoken["access_token"].(string))
	if err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}
	name := userInfo["first_name"].(string)

	var existingUser models.User
	err = database.DB.Where("intra_id = ?", userInfo["login"]).First(&existingUser).Error
	if err == nil {
		tokenVersion := token.Login(existingUser.ID)
		accessToken, err := token.GenerateAccessToken(existingUser.ID, tokenVersion)
		if err != nil {
			return c.Status(apierr.CodeToStatus(4)).JSON(apierr.CodeToErr(4))
		}

		return c.JSON(fiber.Map{
			"is_new_user":  false,
			"access_token": accessToken,
			"name":         name,
		})
	} else if !errors.Is(err, gorm.ErrRecordNotFound) {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	return c.JSON(fiber.Map{
		"is_new_user":  true,
		"access_token": oauthtoken["access_token"],
		"name":         name,
	})
}

type Register42Request struct {
	Username    string `json:"username"`
	AccessToken string `json:"access_token"`
}

type IntraUser struct {
	ID    int    `json:"id"`
	Login string `json:"login"`
	Email string `json:"email"`
	Image struct {
		Link     string `json:"link"`
		Versions struct {
			Large  string `json:"large"`
			Medium string `json:"medium"`
			Small  string `json:"small"`
			Micro  string `json:"micro"`
		} `json:"versions"`
	} `json:"image"`
}

func Register42Handler(c fiber.Ctx) error {
	var req Register42Request
	if err := c.Bind().Body(&req); err != nil {
		return c.Status(apierr.CodeToStatus(1)).JSON(apierr.CodeToErr(1))
	}

	req.AccessToken = strings.TrimSpace(req.AccessToken)
	req.Username = strings.TrimSpace(req.Username)
	if !validUsername.MatchString(req.Username) {
		return c.Status(apierr.CodeToStatus(6)).JSON(apierr.CodeToErr(6))
	}

	var existing models.User
	err := database.DB.Where("username = ?", req.Username).First(&existing).Error
	if err == nil {
		return c.Status(apierr.CodeToStatus(8)).JSON(apierr.CodeToErr(8))
	}
	if !errors.Is(err, gorm.ErrRecordNotFound) {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	userInfo, err := fromTokenGetUserInfo(req.AccessToken)
	if err != nil || userInfo == nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}

	var u IntraUser
	userInfoJSON, err := json.Marshal(userInfo)
	if err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}
	if err := json.Unmarshal(userInfoJSON, &u); err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}

	err = database.DB.Where("intra_id = ?", u.Login).First(&existing).Error
	if err == nil {
		return c.Status(apierr.CodeToStatus(10)).JSON(apierr.CodeToErr(10))
	}
	if !errors.Is(err, gorm.ErrRecordNotFound) {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	user := models.User{
		Username:  req.Username,
		AvatarURL: u.Image.Link,
		IntraID:   u.Login,
		IsIntra:   true,
	}
	if err := database.DB.Create(&user).Error; err != nil {
		return c.Status(apierr.CodeToStatus(11)).JSON(apierr.CodeToErr(11))
	}

	tokenVersion := token.Login(user.ID)
	accessToken, err := token.GenerateAccessToken(user.ID, tokenVersion)
	if err != nil {
		return c.Status(apierr.CodeToStatus(4)).JSON(apierr.CodeToErr(4))
	}

	return c.JSON(fiber.Map{
		"access_token": accessToken,
	})
}
