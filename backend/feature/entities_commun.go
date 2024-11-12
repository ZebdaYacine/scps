package feature

import (
	"scps-backend/feature/auth/domain/entities"
	profileEntities "scps-backend/feature/profile/domain/entities"
)

type User struct {
	Id         string  `json:"id" bson:"id"`
	InsurdNbr  string  `json:"insurdNbr" bson:"insurdNbr"`
	Nbr        int     `json:"nbr" bson:"nbr"`
	Name       string  `json:"name" bson:"name"`
	Email      string  `json:"email" bson:"email"`
	Password   string  `json:"password" bson:"password"`
	Phone      string  `json:"phone" bson:"phone"`
	Permission string  `json:"permission" bson:"permission"`
	Son        []Son   `json:"son" bson:"son"`
	Visit      []Visit `json:"visit" bson:"visit"`
	Role       int     `json:"role,omitempty" bson:"role,omitempty"`
}

type Son struct {
	InsurdNbr string  `json:"insurdNbr" bson:"insurdNbr"`
	Nbr       int     `json:"nbr" bson:"nbr"`
	Status    string  `json:"status" bson:"status"`
	Name      string  `json:"name" bson:"name"`
	Visit     []Visit `json:"visit" bson:"visit"`
}

type Visit struct {
	Nbr       int `json:"nbr" bson:"nbr"`
	Trimester int `json:"trimester" bson:"trimester"`
}

type Account interface {
	User | entities.Login | entities.SetEmail |
		entities.ReciveOTP | entities.SetPwd | profileEntities.InformationsCard
}
