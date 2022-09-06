package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func regionInfo(w http.ResponseWriter, r *http.Request) {

	if r.Method != "GET" {
		http.Error(w, "Method is not supported.", http.StatusNotFound)
		return
	}

	fmt.Fprintf(w, "Hello!, This app is deployed in region : %s", os.Getenv("region"))
}

func main() {

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Welcome to sample Go App, deployed in GCP")

	})

	http.HandleFunc("/region", regionInfo)

	fmt.Printf("Starting web server server at port 8080\n")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
