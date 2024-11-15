package pkg

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/joho/godotenv"
)

func LoadEnv() {
	// err := godotenv.Load("../.env")
	err := godotenv.Load(".env")
	if err != nil {
		log.Println("Warning: .env file not found; using environment variables")
	}
}

type DB_SERVER struct {
	USER_DB           string
	PASSWORD_DB       string
	SERVER_ADDRESS_DB string
	DB_NAME           string
}

type ROOT_SERVER struct {
	SERVER_ADDRESS string
	SERVER_PORT    string
	SECRET_KEY     string
}

type SMTP_SERVER struct {
	SMTP_HOST string
	SMTP_PORT int
	SMTP_USER string
	SMTP_PASS string
}

func GET_ROOT_SERVER_SEETING() ROOT_SERVER {
	LoadEnv()
	port := os.Getenv("PORT")
	if port == "" {
		port = "3000"
	}
	return ROOT_SERVER{
		SERVER_ADDRESS: os.Getenv("SERVER_ADDRESS"),
		SERVER_PORT:    port,
		SECRET_KEY:     os.Getenv("SECRET_KEY"),
	}
}

func GET_DB_SERVER_SEETING() DB_SERVER {
	LoadEnv()
	return DB_SERVER{
		USER_DB:           os.Getenv("USER_DB"),
		PASSWORD_DB:       os.Getenv("PASSWORD_DB"),
		SERVER_ADDRESS_DB: os.Getenv("SERVER_ADDRESS_DB"),
		DB_NAME:           os.Getenv("DB_NAME"),
	}
}

func GET_SMTP_SERVER_SEETING() SMTP_SERVER {
	LoadEnv()
	PORT, err := strconv.Atoi(os.Getenv("SMTP_PORT"))
	if err != nil {
		fmt.Println("Error:", err)
	} else {
		PORT = 587
	}
	return SMTP_SERVER{
		SMTP_HOST: os.Getenv("SMTP_HOST"),
		SMTP_PORT: PORT,
		SMTP_USER: os.Getenv("SMTP_USER"),
		SMTP_PASS: os.Getenv("SMTP_PASS"),
	}
}

func Get_URL() string {
	LoadEnv()
	url := fmt.Sprintf("%s:%s", os.Getenv("SERVER_ADDRESS"), os.Getenv("SERVER_PORT"))
	return url
}
