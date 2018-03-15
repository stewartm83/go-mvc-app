package auth

import "time"

type UserDB interface {
	CreateUser(user User) (int, error)
	UpdateUser(user User) (int, error)
	DeleteUser(user User) (int, error)
	GetUsers() ([]User, error)
	GetUserById(userId int) (User, error)
	GetUserByName(username string) (User, error)
}

type RoleDB interface {
	CreateRole(role Role) (int, error)
	UpdateRole(role Role) (int, error)
	DeleteRole(role Role) (int, error)
	GetRoles() ([]Role, error)
	GetRoleById(roleId int) (Role, error)
	GetRoleByName(rolename string) (Role, error)
}

type AuthenticationManager interface {
	Login(username, password string) error
	SetPassword(userId int, password string) error
	ForgotPassword(userId int, expires time.Time) (string, error)
	ResetPassword(userId int, token string, password string) error
	Logout(userId int) error
}

type TokenProvider struct {
}

func (tp *TokenProvider) Generate(purpose string, user User) {
}

func (tp *TokenProvider) Notify(token Token, user User) {
}

func (tp *TokenProvider) Validate(purpose string, token Token, user User) {
}
