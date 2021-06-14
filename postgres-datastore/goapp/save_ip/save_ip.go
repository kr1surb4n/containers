package main

import (
	"database/sql"
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
	const (
		_Provide_arguments = "Provide arguments: save_ip <hostname> <address_type|interface> <ip>"
	)
	var (
		hostname     string
		ip           string
		address_type string
	)

	//////////////////////////////////////////
	//connect to db
	db := connect_to_db()

	//get type from command line
	if len(os.Args) == 4 {
		hostname = os.Args[1]
		address_type = os.Args[2]
		ip = os.Args[3]
	} else {
		log.Fatal(_Provide_arguments)
	}

	stmt, err := db.Prepare("INSERT INTO host_index(hostname, interface, ip) VALUES($1, $2, $3)")
	if err != nil {
		log.Fatal(err)
	}
	res, err := stmt.Exec(hostname, address_type, ip)
	if err != nil {
		log.Fatal(err)
	}
	lastId, err := res.LastInsertId()
	if err != nil {
		log.Fatal(err)
	}
	rowCnt, err := res.RowsAffected()
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("ID = %d, affected = %d\n", lastId, rowCnt)

	//exit
	os.Exit(0)
}
