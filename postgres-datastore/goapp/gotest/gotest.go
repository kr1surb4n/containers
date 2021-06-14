package main

import (
	"fmt"
	"os"
)

func main() {

	fmt.Println(os.Args, os.Args[1])

	if len(os.Args) > 1 {
		//do something here
		val := os.Args[1]
		fmt.Println(val)
	}

	fmt.Println("Hello, world.")
}
