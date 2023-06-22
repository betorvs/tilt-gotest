package main

import (
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
)

var (
	build = "develop"
)

func getRoot(w http.ResponseWriter, r *http.Request) {
	_, _ = io.WriteString(w, "OK\n")
}

func getInfo(w http.ResponseWriter, r *http.Request) {
	values := fmt.Sprintf("Information:\n Version %s ", build)
	_, _ = io.WriteString(w, values)
}

func main() {

	mux := http.NewServeMux()
	mux.HandleFunc("/", getRoot)
	mux.HandleFunc("/info", getInfo)

	var port string
	if val, ok := os.LookupEnv("PORT"); ok {
		port = ":" + val
	} else {
		port = ":9090"
	}
	fmt.Println("starting server on ", port)
	err := http.ListenAndServe(port, mux)
	if errors.Is(err, http.ErrServerClosed) {
		fmt.Printf("server closed\n")
	} else if err != nil {
		fmt.Printf("error listening for server: %s\n", err)
	}
}
