package repository

import (
	"context"
	"fmt"
	"log"
	"scps-backend/core"
	"scps-backend/feature"
	domain "scps-backend/feature/auth/domain/entities"
	"scps-backend/pkg/database"
	"scps-backend/util/email"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

type authRepository struct {
	database database.Database
}

type AuthRepository interface {
	Login(c context.Context, data *domain.Login) (*feature.User, error)
	CreateAccount(c context.Context, user *feature.User) (*feature.User, error)
	SetPassword(c context.Context, pwd string, eamil string) (bool, error)
	SearchIfEamilExiste(c context.Context, email string) (*feature.User, error)
}

func NewAuthRepository(db database.Database) AuthRepository {
	return &authRepository{
		database: db,
	}
}

func getUser(filter any, collection database.Collection, c context.Context, agant string) (*feature.User, error) {
	var result bson.M
	err := collection.FindOne(c, filter).Decode(&result)
	if err != nil {
		log.Print(err)
		return nil, err
	}
	user := feature.User{}
	user = feature.User{
		Id:         result["_id"].(primitive.ObjectID).Hex(),
		Permission: result["permission"].(string),
		Email:      result["email"].(string),
		Name:       result["name"].(string),
	}
	switch agant {
	case "USER":
		user.InsurdNbr = result["insurdNbr"].(string)
	case "SUPER-USER":
		user.InsurdNbr = result["post"].(string)
	}
	return &user, nil
}

// CreateProfile implements ProfileRepository.
func (s *authRepository) CreateAccount(c context.Context, user *feature.User) (*feature.User, error) {
	collection := s.database.Collection("user")
	user.Permission = "USER"
	user.Request = false
	user.Status = ""
	user.LinkFile = ""
	currentT := (int(time.Now().Month()) / 3) + 1
	user.Visit = []feature.Visit{
		{
			Nbr:       0,
			Trimester: currentT,
		},
	}
	count, err := collection.CountDocuments(c, map[string]interface{}{})
	if err != nil {
		log.Fatalf("Failed to count documents: %v", err)
	}
	code, err := email.GenerateDigit()
	if err != nil {
		log.Panicf(err.Error())
	}
	user.InsurdNbr = fmt.Sprintf("%s%d%d", code, count, 2024)
	log.Println(user)
	resulat, err := collection.InsertOne(c, &user)
	if err != nil {
		log.Printf("Failed to create user: %v", err)
		return nil, err
	}
	userId := resulat.(string)
	user.Id = userId
	id, err := primitive.ObjectIDFromHex(user.Id)
	if err != nil {
		log.Fatal(err)
	}
	filterUpdate := bson.D{{Key: "_id", Value: id}}
	update := bson.M{
		"$set": user,
	}
	_, err = collection.UpdateOne(c, filterUpdate, update)
	if err != nil {
		log.Panic(err)
		return nil, err
	}
	new_user := &feature.User{}
	err = collection.FindOne(c, filterUpdate).Decode(new_user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			return nil, fmt.Errorf("user not found")
		}
		return nil, err
	}

	return new_user, nil
}

func (r *authRepository) Login(c context.Context, data *domain.Login) (*feature.User, error) {
	collection := r.database.Collection("user")
	filter := bson.D{}
	if data.Agant == "USER" {
		filter = bson.D{{Key: "insurdNbr", Value: data.UserName}, {Key: "password", Value: data.Password}}
	} else if data.Agant == "SUPER-USER" {
		filter = bson.D{{Key: "post", Value: data.UserName}, {Key: "password", Value: data.Password}}
	}
	user, err := getUser(filter, collection, c, data.Agant)
	if err != nil {
		log.Print(err)
		return nil, err
	}
	user.Email = data.UserName
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
	user, err := getUser(filter, collection, c, "")
	if err != nil {
		//log.Print(err)
		return nil, err
	}
	return user, nil
}
