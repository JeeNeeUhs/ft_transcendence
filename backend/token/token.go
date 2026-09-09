package token

import (
	"errors"
	"time"

	"github.com/JeeNeeUhs/ft_transcendence/config"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
)

var Secret = []byte(config.JwtSecret)

const (
	Issuer    = "transcendence"
	AccessTTL = 60 * 24 * 7 * time.Minute
)

type AccessClaims struct {
	UserID       uuid.UUID `json:"uid"`
	TokenVersion int       `json:"tv"`
	jwt.RegisteredClaims
}

func GenerateAccessToken(userID uuid.UUID, tokenVersion int) (string, error) {
	now := time.Now()
	claims := AccessClaims{
		UserID:       userID,
		TokenVersion: tokenVersion,
		RegisteredClaims: jwt.RegisteredClaims{
			Subject:   userID.String(),
			Issuer:    Issuer,
			IssuedAt:  jwt.NewNumericDate(now),
			NotBefore: jwt.NewNumericDate(now),
			ExpiresAt: jwt.NewNumericDate(now.Add(AccessTTL)),
		},
	}
	return jwt.NewWithClaims(jwt.SigningMethodHS256, claims).SignedString(Secret)
}

func ParseAccessToken(tokenString string) (*AccessClaims, error) {
	claims := &AccessClaims{}
	parsed, err := jwt.ParseWithClaims(tokenString, claims, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, errors.New("unexpected signing method")
		}
		return Secret, nil
	})
	if err != nil {
		return nil, err
	}
	if !parsed.Valid {
		return nil, errors.New("invalid token")
	}
	return claims, nil
}
