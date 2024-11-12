package usecase

import (
	"context"
	"scps-backend/feature"
	profileRepo "scps-backend/feature/profile/domain/repository"
)

type ProfileParams struct {
	Data any
}

type ProfileResult struct {
	Data any
	Err  error
}

type ProfileUsecase interface {
	CreateProfile(c context.Context, user *ProfileParams) *ProfileResult
	GetProfile(c context.Context, data *ProfileParams) *ProfileResult
	GetInformationCard(c context.Context, data *ProfileParams) *ProfileResult
}

type profileUsecase struct {
	repo       profileRepo.ProfileRepository
	collection string
}

// SearchIfEamilExiste implements ProfileUsecase.

func NewProfileUsecase(repo profileRepo.ProfileRepository, collection string) ProfileUsecase {
	return &profileUsecase{
		repo:       repo,
		collection: collection,
	}
}

// Login implements UserUsecase.
func (p *profileUsecase) GetProfile(c context.Context, data *ProfileParams) *ProfileResult {
	profileResult, err := p.repo.GetProfile(c, data.Data.(string))
	if err != nil {
		return &ProfileResult{Err: err}
	}
	return &ProfileResult{Data: profileResult}
}

func (p *profileUsecase) GetInformationCard(c context.Context, data *ProfileParams) *ProfileResult {
	profileResult, err := p.repo.GetInformationCard(c, data.Data.(string))
	if err != nil {
		return &ProfileResult{Err: err}
	}
	return &ProfileResult{Data: profileResult}
}

// CreateProfile implements ProfileUsecase.
func (p *profileUsecase) CreateProfile(c context.Context, user *ProfileParams) *ProfileResult {
	profileResult, err := p.repo.CreateProfile(c, user.Data.(*feature.User))
	if err != nil {
		return &ProfileResult{Err: err}
	}
	return &ProfileResult{Data: profileResult}
}
