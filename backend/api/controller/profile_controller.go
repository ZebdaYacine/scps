package controller

import (
	"log"
	"net/http"
	"scps-backend/api/controller/model"
	"scps-backend/core"

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

func (ic *ProfileController) GetInformationProfileRequest(c *gin.Context) {
	log.Println("************************ GET INFORMATIONS CARD REQUEST ************************")
	var informationsParms entities.InformationsCard
	if !core.IsDataRequestSupported(&informationsParms, c) {
		return
	}
	log.Println(informationsParms)
	profileParams := &usecase.ProfileParams{}
	profileParams.Data = informationsParms
	resulat := ic.ProfileUsecase.GetInformationCard(c, profileParams)
	if err := resulat.Err; err != nil {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, model.SuccessResponse{
		Message: "INFORMATION PROFILE SUCCESSFULY",
		Data:    informationsParms,
	})
}
