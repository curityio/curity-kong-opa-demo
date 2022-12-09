package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/gorilla/mux"
)

var records *[]Record
var file = "./data/records.json"

func main() {
	// readFile()
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/api/records", getRecords)
	router.HandleFunc("/api/records/{id}", getRecord)

	fmt.Println("Server started")
	log.Fatal(http.ListenAndServe(":8080", router))
}

// Load data from file
func readFile() {
	file, e := ioutil.ReadFile(file)
	if e != nil {
		fmt.Printf("File error %v\n", e)
		os.Exit(1)
	}

	json.Unmarshal(file, &records)
}

// Return the records
func getRecords(w http.ResponseWriter, r *http.Request) {
	readFile()
	w.Header().Set("Content-Type", "application/json")

	json.NewEncoder(w).Encode(records)
}

// Return record with given ID
func getRecord(w http.ResponseWriter, r *http.Request) {
	readFile()
	w.Header().Set("Content-Type", "application/json")
	vars := mux.Vars(r)

	for _, record := range *records {
		if strconv.Itoa(record.ID) == vars["id"] {
			json.NewEncoder(w).Encode(record)
			log.Default().Println("Returning record #" + vars["id"])
			return
		}
	}

	json.NewEncoder(w).Encode(&Record{})
}
