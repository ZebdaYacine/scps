package controller

import (
	"log"
	"net/http"
	"scps-backend/api/controller/model"
	"scps-backend/core"
	"scps-backend/feature"

	"scps-backend/feature/profile/domain/entities"
	"scps-backend/feature/profile/usecase"

	"github.com/gin-gonic/gin"
)

type ProfileController struct {
	ProfileUsecase usecase.ProfileUsecase
}

// HANDLE WITH LOGIN ACCOUNT REQUEST
func (ic *ProfileController) GetProfileRequest(c *gin.Context) {
	log.Println("************************ GET PROFILE REQUEST ************************")
	userId := core.GetIdUser(c)
	profileParams := &usecase.ProfileParams{}
	profileParams.Data = userId
	resulat := ic.ProfileUsecase.GetProfile(c, profileParams)
	if err := resulat.Err; err != nil {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, model.SuccessResponse{
		Message: "GET PROFILE SUCCESSFULY",
		Data:    resulat.Data,
	})
}

func (ic *ProfileController) SendDemandRequest(c *gin.Context) {
	log.Println("************************ SEND DEMAND REQUEST ************************")
	var likn entities.Link
	if !core.IsDataRequestSupported(&likn, c) {
		return
	}
	userId := core.GetIdUser(c)
	user := &feature.User{}
	user.Id = userId
	user.LinkFile = likn.LinkFile
	profileParams := &usecase.ProfileParams{}
	profileParams.Data = user
	resulat := ic.ProfileUsecase.ReciveDemand(c, profileParams)
	if err := resulat.Err; err != nil {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, model.SuccessResponse{
		Message: "DEMAND  RECORDED  SUCCESSFULY",
		Data:    resulat.Data,
	})
}

func (ic *ProfileController) GetInformationProfileRequest(c *gin.Context) {
	log.Println("************************ GET INFORMATIONS CARD REQUEST ************************")
	var informationsParms entities.InformationsCard
	if !core.IsDataRequestSupported(&informationsParms, c) {
		return
	}
	profileParams := &usecase.ProfileParams{}
	profileParams.Data = informationsParms.SecurityId
	resulat := ic.ProfileUsecase.GetInformationCard(c, profileParams)
	if err := resulat.Err; err != nil {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, model.SuccessResponse{
		Message: "INFORMATION PROFILE SUCCESSFULY",
		Data:    resulat.Data,
	})
}

func (ic *ProfileController) GetAllDemandRequest(c *gin.Context) {
	log.Println("************************ GET ALL PENDING DEMNADS REQUEST ************************")
	resulat := ic.ProfileUsecase.GetAllDemands(c)
	if err := resulat.Err; err != nil {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, model.SuccessResponse{
		Message: "GET ALL PENDING DEMNADS SUCCESSFULY",
		Data:    resulat.Data,
	})
}

func (ic *ProfileController) UpdateDemandRequestt(c *gin.Context) {
	log.Println("************************ UPDATE PROFILE REQUEST ************************")
	var updateProfile entities.UpdateProfile
	if !core.IsDataRequestSupported(&updateProfile, c) {
		return
	}
	profileParams := &usecase.ProfileParams{}
	profileParams.Data = updateProfile
	resulat := ic.ProfileUsecase.UpdateDemand(c, profileParams)
	if err := resulat.Err; err != nil {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, model.SuccessResponse{
		Message: "UPDATE PROFILE SUCCESSFULY",
		Data:    resulat.Data,
	})
}
