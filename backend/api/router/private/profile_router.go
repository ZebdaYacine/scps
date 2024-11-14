package private

import (
	"scps-backend/api/controller"
	"scps-backend/feature/profile/domain/repository"
	"scps-backend/feature/profile/usecase"
	"scps-backend/pkg/database"

	"github.com/gin-gonic/gin"
)

func NewGetProfileSuRouter(db database.Database, group *gin.RouterGroup) {
	ir := repository.NewProfileRepository(db)
	uc := usecase.NewProfileUsecase(ir, "")
	ic := &controller.ProfileController{
		ProfileUsecase: uc,
	}
	group.GET("get-profile", ic.GetProfileRequest)
}
func NewGetProfileRouter(db database.Database, group *gin.RouterGroup) {
	ir := repository.NewProfileRepository(db)
	uc := usecase.NewProfileUsecase(ir, "")
	ic := &controller.ProfileController{
		ProfileUsecase: uc,
	}
	group.GET("get-profile", ic.GetProfileRequest)
}

func NewGetInformationsCardRouter(db database.Database, group *gin.RouterGroup) {
	ir := repository.NewProfileRepository(db)
	uc := usecase.NewProfileUsecase(ir, "")
	ic := &controller.ProfileController{
		ProfileUsecase: uc,
	}
	group.POST("get-information-card", ic.GetInformationProfileRequest)
}

func NewSendDemandRouter(db database.Database, group *gin.RouterGroup) {
	ir := repository.NewProfileRepository(db)
	uc := usecase.NewProfileUsecase(ir, "")
	ic := &controller.ProfileController{
		ProfileUsecase: uc,
	}
	group.POST("send-demand", ic.SendDemandRequest)
}
