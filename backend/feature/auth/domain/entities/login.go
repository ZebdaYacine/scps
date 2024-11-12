package entities

type Login struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type InformationsCard struct {
	SecurityId string `json:"securityId"`
}

type SetEmail struct {
	Email string `json:"email"`
}

type ReciveOTP struct {
	Otp string `json:"otp"`
}

type SetPwd struct {
	Pwd1 string `json:"pwd1"`
	Pwd2 string `json:"pwd2"`
}
