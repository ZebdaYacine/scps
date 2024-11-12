package repository

import (
	"context"
	"fmt"
	"log"
	"scps-backend/feature"
	"scps-backend/pkg/database"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

type profileRepository struct {
	database database.Database
}

type ProfileRepository interface {
	CreateProfile(c context.Context, user *feature.User) (*feature.User, error)
	UpdateIdProfile(c context.Context, user *feature.User) (*feature.User, error)
	GetProfile(c context.Context, userId string) (*feature.User, error)
	GetInformationCard(c context.Context, userId string) (*feature.User, error)
}

func NewProfileRepository(db database.Database) ProfileRepository {
	return &profileRepository{
		database: db,
	}
}

// CreateProfile implements ProfileRepository.
func (s *profileRepository) CreateProfile(c context.Context, user *feature.User) (*feature.User, error) {
	collection := s.database.Collection("user")
	resulat, err := collection.InsertOne(c, &user)
	if err != nil {
		log.Printf("Failed to create user: %v", err)
		return nil, err
	}
	userId := resulat.(string)
	user.Id = userId
	user, err = s.UpdateIdProfile(c, user)
	if err != nil {
		log.Printf("Failed to update survey: %v", err)
		return nil, err
	}
	return user, nil
}

func (s *profileRepository) UpdateIdProfile(c context.Context, user *feature.User) (*feature.User, error) {
	collection := s.database.Collection("user")
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
func (r *profileRepository) GetProfile(c context.Context, userId string) (*feature.User, error) {
	var result bson.M // MongoDB result should be a bson.M (map)
	id, err := primitive.ObjectIDFromHex(userId)
	if err != nil {
		log.Fatal(err)
	}
	filter := bson.D{{Key: "_id", Value: id}}
	collection := r.database.Collection("user")
	err = collection.FindOne(c, filter).Decode(&result)
	if err != nil {
		log.Print(err)
		return nil, err
	}
	user := feature.User{
		InsurdNbr:  result["insurdNbr"].(string),
		Permission: result["permission"].(string),
		Name:       result["name"].(string),
		Phone:      result["phone"].(string),
		Email:      result["email"].(string),
	}
	return &user, nil
}

func (r *profileRepository) GetInformationCard(c context.Context, securityId string) (*feature.User, error) {
	var result bson.M
	filter := bson.D{{Key: "insurdNbr", Value: securityId}}
	collection := r.database.Collection("user")
	err := collection.FindOne(c, filter).Decode(&result)
	if err != nil {
		log.Print(err)
		return nil, err
	}

	var sons []feature.Son
	for _, sonItem := range result["son"].(bson.A) {
		sonMap := sonItem.(primitive.M)
		sons = append(sons, feature.Son{
			Name:      sonMap["name"].(string),
			InsurdNbr: sonMap["insurdNbr"].(string),
			Status:    sonMap["status"].(string),
			Visit:     convertObject(result["visit"].(primitive.A)),
		})
	}
	user := feature.User{
		InsurdNbr:  result["insurdNbr"].(string),
		Permission: result["permission"].(string),
		Name:       result["name"].(string),
		Phone:      result["phone"].(string),
		Email:      result["email"].(string),
		Son:        sons,
		Visit:      convertObject(result["visit"]),
	}
	return &user, nil
}

func convertObject(data interface{}) []feature.Visit {
	var visits []feature.Visit
	for _, visitItem := range data.(bson.A) {
		visitMap := visitItem.(primitive.M)

		// Safely convert nbr and trimester to int if they are int32 or int64
		nbr := visitMap["nbr"]
		trimester := visitMap["trimester"]

		// Handle type assertions for nbr and trimester to int
		var visitNbr int
		var visitTrimester int

		switch v := nbr.(type) {
		case int32:
			visitNbr = int(v)
		case int64:
			visitNbr = int(v)
		default:
			visitNbr = nbr.(int) // fall back to int
		}

		switch v := trimester.(type) {
		case int32:
			visitTrimester = int(v)
		case int64:
			visitTrimester = int(v)
		default:
			visitTrimester = trimester.(int) // fall back to int
		}

		visits = append(visits, feature.Visit{
			Nbr:       visitNbr,
			Trimester: visitTrimester,
		})
	}
	return visits
}
