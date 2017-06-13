package config

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
)

var DB *sql.DB

func init() {
	var err error

    user := os.Getenv("DB_USERNAME")
	    fmt.Println(user)
    pass := os.Getenv("DB_PASSWORD")
		    fmt.Println(pass)
    dbname := os.Getenv("DB_NAME") 
		    fmt.Println(dbname)
		    
   DB, err = sql.Open("postgres", "postgres://"+user+ ":"+pass+"@localhost/"+dbname+"?sslmode=disable")

	if err != nil {
		panic(err)
	}

	if err = DB.Ping(); err != nil {
		panic(err)
	}
	fmt.Println("You connected to your database.")
}
