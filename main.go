package main

import (
	"log"
	"mime"
	"net/http"
	"os"
	"time"

	"github.com/atotto/clipboard"
)

func main() {
	log.SetPrefix("")
	log.SetFlags(0)

	img, err := clipboard.ReadAll()
	if err != nil {
		log.Fatalf("unable to read clipboard: %v", err)
	}
	imgData := []byte(img)

	var ext string
	mimetype := http.DetectContentType(imgData)
	exts, err := mime.ExtensionsByType(mimetype)
	if len(exts) > 0 {
		ext = exts[len(exts)-1]
	}

	name := time.Now().Format(time.RFC3339)
	path := name + ext
	if len(os.Args) > 1 {
		path = os.Args[1]
	}

	if err := os.WriteFile(
		path,
		[]byte(img),
		0666,
	); err != nil {
		log.Fatalf("unable to store image as %v: %v", name, err)
	}
}
