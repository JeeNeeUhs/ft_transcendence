package user

import (
	"crypto/rand"
	"errors"
	"io"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/JeeNeeUhs/ft_transcendence/apierr"
	"github.com/JeeNeeUhs/ft_transcendence/config"
	"github.com/JeeNeeUhs/ft_transcendence/database"
	"github.com/JeeNeeUhs/ft_transcendence/middleware"
	"github.com/JeeNeeUhs/ft_transcendence/models"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
)

const (
	MaxAvatarSize       = 5 * 1024 * 1024
	avatarFormField     = "avatar"
	avatarURLPrefix     = "/api/user/avatars/"
	avatarSuffix        = "-avatar"
	avatarPrefixLength  = 8
	avatarPrefixCharset = "abcdefghijklmnopqrstuvwxyz0123456789"
)

var avatarExtensions = map[string]string{
	"image/jpeg": ".jpg",
	"image/png":  ".png",
}

var (
	errUnsupportedAvatar = errors.New("user: unsupported avatar type")
	errAvatarTooLarge    = errors.New("user: avatar too large")
)

func UploadAvatarHandler(c fiber.Ctx) error {
	userID, ok := c.Locals(middleware.LocalsUserIDKey).(uuid.UUID)
	if !ok {
		return c.Status(apierr.CodeToStatus(13)).JSON(apierr.CodeToErr(13))
	}

	var user models.User
	if err := database.DB.First(&user, "id = ?", userID).Error; err != nil {
		return c.Status(apierr.CodeToStatus(9)).JSON(apierr.CodeToErr(9))
	}

	header, err := c.FormFile(avatarFormField)
	if err != nil {
		return c.Status(apierr.CodeToStatus(42)).JSON(apierr.CodeToErr(42))
	}

	name, err := storeAvatar(header, user.Username)
	if err != nil {
		code := avatarErrToCode(err)
		return c.Status(apierr.CodeToStatus(code)).JSON(apierr.CodeToErr(code))
	}

	url := config.ApiURL + avatarURLPrefix + name
	if err := database.DB.Model(&user).Update("avatar_url", url).Error; err != nil {
		return c.Status(apierr.CodeToStatus(5)).JSON(apierr.CodeToErr(5))
	}

	return c.JSON(fiber.Map{"avatar_url": url})
}

func storeAvatar(header *multipart.FileHeader, username string) (string, error) {
	if header.Size > MaxAvatarSize {
		return "", errAvatarTooLarge
	}

	src, err := header.Open()
	if err != nil {
		return "", err
	}
	defer src.Close()

	ext, err := detectAvatarExt(src)
	if err != nil {
		return "", err
	}

	if err := os.MkdirAll(config.AvatarDir, 0o755); err != nil {
		return "", err
	}

	tmp, err := stageAvatar(src)
	if err != nil {
		return "", err
	}
	defer os.Remove(tmp)

	if err := removeAvatars(username); err != nil {
		return "", err
	}

	prefix, err := randomAvatarPrefix()
	if err != nil {
		return "", err
	}

	name := prefix + "-" + avatarBaseName(username) + ext
	if err := os.Rename(tmp, filepath.Join(config.AvatarDir, name)); err != nil {
		return "", err
	}

	return name, nil
}

func avatarBaseName(username string) string {
	return username + avatarSuffix
}

func randomAvatarPrefix() (string, error) {
	const maxByte = 256 - (256 % len(avatarPrefixCharset))

	prefix := make([]byte, avatarPrefixLength)
	buf := make([]byte, 1)
	for i := 0; i < avatarPrefixLength; {
		if _, err := rand.Read(buf); err != nil {
			return "", err
		}
		if int(buf[0]) >= maxByte {
			continue
		}
		prefix[i] = avatarPrefixCharset[int(buf[0])%len(avatarPrefixCharset)]
		i++
	}
	return string(prefix), nil
}

func avatarErrToCode(err error) int {
	switch {
	case errors.Is(err, errAvatarTooLarge):
		return 43
	case errors.Is(err, errUnsupportedAvatar):
		return 44
	default:
		return 45
	}
}

func detectAvatarExt(src io.ReadSeeker) (string, error) {
	head := make([]byte, 512)
	n, err := io.ReadFull(src, head)
	if err != nil && !errors.Is(err, io.EOF) && !errors.Is(err, io.ErrUnexpectedEOF) {
		return "", err
	}
	if _, err := src.Seek(0, io.SeekStart); err != nil {
		return "", err
	}

	ext, ok := avatarExtensions[http.DetectContentType(head[:n])]
	if !ok {
		return "", errUnsupportedAvatar
	}
	return ext, nil
}

func stageAvatar(src io.Reader) (string, error) {
	tmp, err := os.CreateTemp(config.AvatarDir, ".avatar-*")
	if err != nil {
		return "", err
	}

	written, err := io.Copy(tmp, io.LimitReader(src, MaxAvatarSize+1))
	if err == nil && written > MaxAvatarSize {
		err = errAvatarTooLarge
	}
	if closeErr := tmp.Close(); err == nil {
		err = closeErr
	}
	if err == nil {
		err = os.Chmod(tmp.Name(), 0o644)
	}
	if err != nil {
		os.Remove(tmp.Name())
		return "", err
	}

	return tmp.Name(), nil
}

func removeAvatars(username string) error {
	entries, err := os.ReadDir(config.AvatarDir)
	if err != nil {
		return err
	}

	base := avatarBaseName(username)
	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}
		name := entry.Name()
		stem := strings.TrimSuffix(name, filepath.Ext(name))
		if stem != base && !strings.HasSuffix(stem, "-"+base) {
			continue
		}
		if err := os.Remove(filepath.Join(config.AvatarDir, name)); err != nil && !os.IsNotExist(err) {
			return err
		}
	}

	return nil
}
