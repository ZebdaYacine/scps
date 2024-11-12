package controller

import (
	"log"
	"net/http"
	"scps-backend/api/controller/model"
	"scps-backend/core"
	"scps-backend/feature"
	authEntitis "scps-backend/feature/auth/domain/entities"

	//userEntitis "scps-backend/feature/users/domain/entities"
	"time"

	"scps-backend/feature/auth/usecase"
	"scps-backend/util/email"
	"scps-backend/util/email/html"
	util "scps-backend/util/token"
	"sync"

	"github.com/gin-gonic/gin"
)

type AuthController struct {
	AuthUsecase usecase.AuthUsecase
}

var codeStore = make(map[string]model.OTPConfirmation)
var mu sync.Mutex

func sendOTP(user feature.User, c *gin.Context, header string) {
	code, err := email.GenerateDigit()
	if err != nil {
		log.Panicf(err.Error())
		c.JSON(500, model.ErrorResponse{Message: err.Error()})
		return
	}
	//SEND EMAIL TO USER WITH CODE
	var htmlMsg html.HtlmlMsg
	htmlMsg.Code = code
	htmlMsg.Name = user.Name
	body := html.HtmlMessageConfirmAccount(htmlMsg)
	err = email.SendEmail(user.Email, header, body)
	if err != nil {
		log.Panicf(err.Error())
		c.JSON(500, model.ErrorResponse{Message: "Can't send confirmation code"})
		return
	}
	clientIP := c.ClientIP()
	mu.Lock()
	codeStore[clientIP] = model.OTPConfirmation{
		Code:         code,
		IP:           clientIP,
		Time_Sending: time.Now(),
		Reason:       "sendOTP",
		Email:        user.Email,
	}
	mu.Unlock()
	log.Print(codeStore[clientIP])
}

func verifyOTP(otp string, c *gin.Context) bool {
	clientIP := c.ClientIP()
	currentTime := time.Now()
	mu.Lock()
	pqtSotred, exists := codeStore[clientIP]
	mu.Unlock()
	if !exists {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{Message: "No code generated for this client"})
		return false
	}
	if otp != pqtSotred.Code {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{Message: "Invalid code"})
		return false
	}
	diff := currentTime.Sub(pqtSotred.Time_Sending).Minutes()
	if diff > 5 {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{Message: "Code expired"})
		return false
	}
	return true
}

// HANDLE WITH LOGIN ACCOUNT REQUEST
func (ic *AuthController) LoginRequest(c *gin.Context) {
	log.Println("************************ RECIEVE LOGIN REQUEST ************************")
	var loginParms authEntitis.Login
	if !core.IsDataRequestSupported(&loginParms, c) {
		return
	}
	log.Println(loginParms)
	authParams := &usecase.AuthParams{}
	authParams.Data = &loginParms
	resulat := ic.AuthUsecase.Login(c, authParams)
	if err := resulat.Err; err != nil {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: err.Error(),
		})
		return
	}
	secret := core.RootServer.SECRET_KEY
	user := resulat.Data.(*feature.User)
	token, err := util.CreateAccessToken(user.Id, secret, 2, user.Permission)
	if err != nil {
		c.JSON(500, model.ErrorResponse{Message: err.Error()})
		return
	}
	// log.Printf("TOKEN %s", token)
	user.Password = ""
	c.JSON(http.StatusOK, model.SuccessResponse{
		Message: "USER LOGGING SUCCESSFULY",
		Data: model.LoginResponse{
			Token:    token,
			UserData: user,
		},
	})
}

// HANDLE WITH LOGIN ACCOUNT REQUEST
func (ic *AuthController) SetEmailRequest(c *gin.Context) {
	log.Println("************************ SET EMAIL REQUEST ************************")
	var SetEmailParms authEntitis.SetEmail
	if !core.IsDataRequestSupported(&SetEmailParms, c) {
		return
	}
	log.Println(SetEmailParms)
	authParams := &usecase.AuthParams{}
	authParams.Data = &SetEmailParms
	resulat := ic.AuthUsecase.SearchIfEamilExiste(c, authParams)
	if err := resulat.Err; err != nil {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: err.Error(),
		})
		return
	}
	user := resulat.Data.(*feature.User)
	sendOTP(feature.User{
		Email: SetEmailParms.Email,
		Name:  user.Name,
	}, c, "OTP")
	c.JSON(http.StatusOK, model.SuccessResponse{
		Message: "SETTING EMAIL SUCCESSFULY",
		Data:    true,
	})
}

func (ic *AuthController) ReciveOTPRequest(c *gin.Context) {
	log.Println("************************ RECIVE OTP REQUEST ************************")
	var OTPParms authEntitis.ReciveOTP
	if !core.IsDataRequestSupported(&OTPParms, c) {
		return
	}
	clientIP := c.ClientIP()
	log.Print(codeStore[clientIP])
	if verifyOTP(OTPParms.Otp, c) {
		log.Println("OTP verification done")
		delete(codeStore, clientIP)
		c.JSON(http.StatusOK, model.SuccessResponse{
			Message: "OTP VERIFICATION DONE SUCCESSFULY",
			Data:    true,
		})
		return
	}

}

func (ic *AuthController) ForgetPwdRequest(c *gin.Context) {
	log.Println("************************ FORGET PASSWORD REQUEST ************************")
	var forgetPwdParms authEntitis.SetPwd
	if !core.IsDataRequestSupported(&forgetPwdParms, c) {
		return
	}
	log.Println(forgetPwdParms)
	authParams := &usecase.AuthParams{}
	authParams.Data = &forgetPwdParms
	resulat := ic.AuthUsecase.SetPassword(c, authParams)
	if err := resulat.Err; err != nil {
		c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, model.SuccessResponse{
		Message: "SETTING PASSWORD SUCCESSFULY",
		Data:    resulat.Data,
	})
}
