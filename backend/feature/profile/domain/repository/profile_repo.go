package repository

import (
	"context"
	"scps-backend/feature"
	"scps-backend/pkg/database"
)

type profileRepository struct {
	database database.Database
}

type ProfileRepository interface {
	GetProfile(c context.Context, userId string) (*feature.User, error)
	GetInformationCard(c context.Context, userId string) (*feature.User, error)
}

func NewProfileRepository(db database.Database) ProfileRepository {
	return &profileRepository{
		database: db,
	}
}

func (r *profileRepository) GetProfile(c context.Context, userId string) (*feature.User, error) {
	return &feature.User{
		Id:         "4j239412nk92u411233mnd",
		InsurdNbr:  "3423405",
		Nbr:        2,
		Phone:      "0658185867",
		Name:       "zebda yacine",
		Email:      "zebdaadam1996@gmail.com",
		Password:   "admin",
		Permission: "User",
		Son: []feature.Son{
			{
				InsurdNbr: "3423403",
				Nbr:       2,
				Status:    "wife",
				Name:      "nasima",
				Visit: []feature.Visit{
					{
						Nbr:       1,
						Trimester: 1,
					},
					{
						Nbr:       2,
						Trimester: 2,
					},
					{
						Nbr:       3,
						Trimester: 3,
					},
				},
			},
			{
				InsurdNbr: "3423409",
				Nbr:       1,
				Status:    "boy",
				Name:      "nasim",
				Visit: []feature.Visit{
					{
						Nbr:       1,
						Trimester: 1,
					},
					{
						Nbr:       2,
						Trimester: 2,
					},
					{
						Nbr:       3,
						Trimester: 3,
					},
				},
			},
		},
		Visit: []feature.Visit{
			{
				Nbr:       1,
				Trimester: 1,
			},
			{
				Nbr:       2,
				Trimester: 2,
			},
			{
				Nbr:       3,
				Trimester: 3,
			},
		},
	}, nil
}

func (r *profileRepository) GetInformationCard(c context.Context, securityId string) (*feature.User, error) {
	return &feature.User{
		Id:         "4j239412nk92u411233mnd",
		InsurdNbr:  "3423405",
		Nbr:        2,
		Phone:      "0658185867",
		Name:       "zebda yacine",
		Email:      "zebdaadam1996@gmail.com",
		Password:   "admin",
		Permission: "User",
		Son: []feature.Son{
			{
				InsurdNbr: "3423403",
				Nbr:       2,
				Status:    "wife",
				Name:      "nasima",
				Visit: []feature.Visit{
					{
						Nbr:       1,
						Trimester: 1,
					},
					{
						Nbr:       2,
						Trimester: 2,
					},
					{
						Nbr:       3,
						Trimester: 3,
					},
				},
			},
			{
				InsurdNbr: "3423409",
				Nbr:       1,
				Status:    "boy",
				Name:      "nasim",
				Visit: []feature.Visit{
					{
						Nbr:       1,
						Trimester: 1,
					},
					{
						Nbr:       2,
						Trimester: 2,
					},
					{
						Nbr:       3,
						Trimester: 3,
					},
				},
			},
		},
		Visit: []feature.Visit{
			{
				Nbr:       1,
				Trimester: 1,
			},
			{
				Nbr:       2,
				Trimester: 2,
			},
			{
				Nbr:       3,
				Trimester: 3,
			},
		},
	}, nil
}
