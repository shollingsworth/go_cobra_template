.DEFAULT_GOAL := help
PROJECT := github.com/shollingsworth
PREFIX := changeme
BUILD_DIR := build
# Run `go tool dist list` to see all os & arch combinations that are supported.
GOOS := linux darwin  # put other OSes here as needed
ARCH := amd64 arm64 # what architectures to build for
ENTRYPOINT := main.go

fmt:
	@go fmt ./...


build: setup clean
	go mod download
	mkdir -p $(BUILD_DIR)/
	for goos in $(GOOS); do \
		if [ "$${goos}" = "windows" ]; then ext=".exe"; else ext="" ; fi; \
		for arch in $(ARCH); do \
			bf="build/$(PREFIX)-$${goos}-$${arch}$${ext}" ; \
			GOOS="$${goos}" GOARCH="$${arch}" go build \
				-trimpath \
				-o "$${bf}" \
				$(ENTRYPOINT) ; \
			echo $${bf}; \
		done \
	done

setup:
	go mod init $(PROJECT)/$(PREFIX) || true
	go mod tidy

clean:
	rm -fv $(BUILD_DIR)/*
