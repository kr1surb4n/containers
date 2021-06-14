package main

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"

	"log"
	"os"
)

var (
	connection_string = os.Getenv("DATABASE_URL")
)

//connStr := "postgres://pqgotest:password@localhost/pqgotest?sslmode=verify-full"

func connect_to_db() *sql.DB {

	db, err := sql.Open("postgres", connection_string)

	if err != nil {
		log.Fatal(err)
	}

	return db
}

func main() {
	//////////////////////////////////////////
	//connect to db
	db := connect_to_db()

	//get type from command line
	var (
		hostname     string
		ip           string
		address_type string
	)

	if len(os.Args) == 2 {
		address_type = os.Args[1]
	}

	//get all with ip with type from db
	result, err := db.Query(`SELECT hostname, ip FROM public.host_index
                                 WHERE interface = $1`, address_type)
	defer result.Close()

	//return to stdin as a list: hostname ip
	for result.Next() {
		err := result.Scan(&hostname, &ip)
		if err != nil {
			log.Fatal(err)
		}

		fmt.Println(hostname, ip)
	}

	err = result.Err()
	if err != nil {
		log.Fatal(err)
	}

	//exit
	os.Exit(0)
}

// var userid int
// err := db.QueryRow(`INSERT INTO users(name, favorite_fruit, age)
// VALUES('beatrice', 'starfruit', 93) RETURNING id`).Scan(&userid)
