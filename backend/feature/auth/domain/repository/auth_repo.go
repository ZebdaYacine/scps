package repository

import (
	"context"
	"log"
	"scps-backend/core"
	"scps-backend/feature"
	domain "scps-backend/feature/auth/domain/entities"
	"scps-backend/pkg/database"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type authRepository struct {
	database database.Database
}

type AuthRepository interface {
	Login(c context.Context, data *domain.Login) (*feature.User, error)
	SetPassword(c context.Context, pwd string, eamil string) (bool, error)
	SearchIfEamilExiste(c context.Context, email string) (*feature.User, error)
}

func NewAuthRepository(db database.Database) AuthRepository {
	return &authRepository{
		database: db,
	}
}

func getUser(filter any, collection database.Collection, c context.Context) (*feature.User, error) {
	var result bson.M
	err := collection.FindOne(c, filter).Decode(&result)
	log.Println(filter)
	if err != nil {
		log.Print(err)
		return nil, err
	}
	user := feature.User{
		Id:         result["_id"].(primitive.ObjectID).Hex(),
		InsurdNbr:  result["insurdNbr"].(string),
		Permission: result["permission"].(string),
		Email:      result["email"].(string),
		Name:       result["name"].(string),
	}
	return &user, nil
}

func (r *authRepository) Login(c context.Context, data *domain.Login) (*feature.User, error) {
	collection := r.database.Collection("user")
	filter := bson.D{{Key: "email", Value: data.Email}, {Key: "password", Value: data.Password}}
	log.Println(data)
	user, err := getUser(filter, collection, c)
	if err != nil {
		log.Print(err)
		return nil, err
	}
	user.Email = data.Email
	return user, nil
}

func (r *authRepository) SetPassword(c context.Context, pwd string, email string) (bool, error) {
	collection := r.database.Collection("user")
	filterUpdate := bson.D{{Key: "email", Value: email}}
	update := bson.M{
		"$set": bson.M{
			"password": pwd,
		},
	}
	_, err := core.UpdateDoc[feature.User](c, collection, update, filterUpdate)
	if err == nil {
		return true, nil
	}
	return false, err
}

func (r *authRepository) SearchIfEamilExiste(c context.Context, email string) (*feature.User, error) {
	collection := r.database.Collection("user")
	filter := bson.D{{Key: "email", Value: email}}
	user, err := getUser(filter, collection, c)
	if err != nil {
		//log.Print(err)
		return nil, err
	}
	return user, nil
}
