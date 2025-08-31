package main

import (
	"context"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"

	"github.com/gosom/google-maps-scraper/runner"
	"github.com/gosom/google-maps-scraper/runner/databaserunner"
	"github.com/gosom/google-maps-scraper/runner/filerunner"
	"github.com/gosom/google-maps-scraper/runner/installplaywright"
	"github.com/gosom/google-maps-scraper/runner/lambdaaws"
	"github.com/gosom/google-maps-scraper/runner/webrunner"
)

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	runner.Banner()

	// Signal handling
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, os.Interrupt, syscall.SIGTERM)
	go func() {
		<-sigChan
		log.Println("Received signal, shutting down...")
		cancel()
	}()

	// Scraper job'larını arka planda çalıştır
	go func() {
		cfg := runner.ParseConfig()
		runnerInstance, err := runnerFactory(cfg)
		if err != nil {
			log.Println("Error creating runner:", err)
			return
		}
		if err := runnerInstance.Run(ctx); err != nil && !errors.Is(err, context.Canceled) {
			log.Println("Error running runner:", err)
		}
		_ = runnerInstance.Close(ctx)
		runner.Telemetry().Close()
	}()

	// HTTP Server (ana thread)
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "Google Maps Scraper is running!")
	})
	log.Println("HTTP server listening on port", port)
	log.Fatal(http.ListenAndServe("0.0.0.0:"+port, nil))
}

func runnerFactory(cfg *runner.Config) (runner.Runner, error) {
	switch cfg.RunMode {
	case runner.RunModeFile:
		return filerunner.New(cfg)
	case runner.RunModeDatabase, runner.RunModeDatabaseProduce:
		return databaserunner.New(cfg)
	case runner.RunModeInstallPlaywright:
		return installplaywright.New(cfg)
	case runner.RunModeWeb:
		return webrunner.New(cfg)
	case runner.RunModeAwsLambda:
		return lambdaaws.New(cfg)
	case runner.RunModeAwsLambdaInvoker:
		return lambdaaws.NewInvoker(cfg)
	default:
		return nil, fmt.Errorf("%w: %d", runner.ErrInvalidRunMode, cfg.RunMode)
	}
}
