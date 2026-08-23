package apierr

type Err struct {
	Status  int    `json:"status"`
	Code    int    `json:"code"`
	Message string `json:"message"`
}

type ErrResponse struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

var registery = map[int]Err{
	0:  {Status: 500, Code: 0, Message: "unknown error"},
	1:  {Status: 400, Code: 1, Message: "invalid request body"},
	2:  {Status: 400, Code: 2, Message: "code is required"},
	3:  {Status: 500, Code: 3, Message: "failed to get access token"},
	4:  {Status: 500, Code: 4, Message: "failed to generate token"},
	5:  {Status: 500, Code: 5, Message: "database error"},
	6:  {Status: 400, Code: 6, Message: "username not valid"},
	7:  {Status: 400, Code: 7, Message: "password not valid"},
	8:  {Status: 409, Code: 8, Message: "username already taken"},
	9:  {Status: 500, Code: 9, Message: "failed to get user info"},
	10: {Status: 409, Code: 10, Message: "intra_id already taken"},
	11: {Status: 500, Code: 11, Message: "failed to create user"},
	12: {Status: 401, Code: 12, Message: "invalid username or password"},
	13: {Status: 401, Code: 13, Message: "unauthorized"},
	14: {Status: 401, Code: 14, Message: "missing authorization header"},
	15: {Status: 401, Code: 15, Message: "invalid authorization header"},
	16: {Status: 401, Code: 16, Message: "invalid or expired token"},
	17: {Status: 401, Code: 17, Message: "token has been invalidated"},
	18: {Status: 400, Code: 18, Message: "room name not valid"},
	19: {Status: 404, Code: 19, Message: "room not found"},
	20: {Status: 409, Code: 20, Message: "already in a room"},
	21: {Status: 409, Code: 21, Message: "already in this room"},
	22: {Status: 500, Code: 22, Message: "failed to generate room id"},
	23: {Status: 400, Code: 23, Message: "room password not valid"},
	24: {Status: 401, Code: 24, Message: "invalid room password"},
	27: {Status: 501, Code: 27, Message: "not implemented"},
	28: {Status: 400, Code: 28, Message: "invalid category id"},
	29: {Status: 400, Code: 29, Message: "duplicate category id"},
	30: {Status: 426, Code: 30, Message: "websocket upgrade required"},
	31: {Status: 429, Code: 31, Message: "rate limit exceeded"},
	32: {Status: 401, Code: 32, Message: "invalid or missing api key"},
}

func CodeToErr(code int) ErrResponse {
	if err, ok := registery[code]; ok {
		var errResp = ErrResponse{
			Code:    err.Code,
			Message: err.Message,
		}
		return errResp
	}
	var errResp = ErrResponse{
		Code:    0,
		Message: "unknown error",
	}
	return errResp
}

func CodeToStatus(code int) int {
	err := registery[code]
	return err.Status
}
