# ########################################################## #
# Makefile for Golang Project
# Includes cross-compiling, installation, cleanup
# ########################################################## #

#The shell we use
SHELL := /bin/bash

# We like colors
# # From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`

# Go settings
BIN_DIR := $(GOPATH)/bin
GOMETALINTER := $(BIN_DIR)/gometalinter
PACKAGE_DIR=pkg

# Build parameters
BINARY=redactor
VERSION := $(shell cat VERSION)
GIT_COMMIT := $(shell git rev-parse --short HEAD)
BUILD_DATE := $(shell date +"%m-%d-%Y")
PLATFORMS=darwin linux windows
ARCHITECTURES=amd64

# Setup linker flags option for build that inter-operate with variable names in source code
#LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.BuildData=${BUILD_DATE}"
LDFLAGS=-ldflags "-X main.Version=${VERSION} -X github.com/testthedocs/redactor/cmd.BuildDate=${BUILD_DATE} -X github.com/testthedocs/redactor/cmd.GitCommit=${GIT_COMMIT} "

# Check for required command tools to build or stop immediately
EXECUTABLES = git go find pwd
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH)))

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: default
default: build ## Builds default binary

all: clean build_all install

.PHONY: build
build: ## Build test binary
	@echo ""
	@echo "$(YELLOW)==> Creating test binaries for $(VERSION)$(RESET)"
	go build ${LDFLAGS} -o $(PACKAGE_DIR)/$(BINARY)_$(VERSION)

build_all:
	$(foreach GOOS, $(PLATFORMS),\
	$(foreach GOARCH, $(ARCHITECTURES), $(shell export GOOS=$(GOOS); export GOARCH=$(GOARCH); go build -v -o $(BINARY)-$(GOOS)-$(GOARCH))))

install:
	go install ${LDFLAGS}

# Remove only what we've created
clean: ## Removing old binaries
	@echo "$(YELLOW)==> Removing old binaries...$(RESET)"
	@if [ -d $(PACKAGE_DIR) ]; then rm -rf $(PACKAGE_DIR); fi;

