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

# Check for required command tools to build or stop immediately
EXECUTABLES = git go find pwd
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH)))

ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Settings
BIN_DIR := $(GOPATH)/bin
GOMETALINTER := $(BIN_DIR)/gometalinter
TEST_BUILDS=test-pkgs
PROD_BUILDS=dist
OS=$(shell uname -s)
BINARY=redactor
VERSION := $(shell cat VERSION)
GIT_COMMIT := $(shell git rev-parse HEAD)
BUILD_DATE:= $(shell date -u +%F)
PLATFORMS=darwin linux windows
ARCHITECTURES=amd64
LD_FLAGS += -s -w

# Setup linker flags option for build that interoperate with variable names in src code
#LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.GitCommit=$(GIT_COMMIT)"
#LDFLAGS += -X main.Version=${VERSION}
#LDFLAGS += -X main.GitCommit=${GIT_COMMIT}

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: default
default: test-build ## Build default test binary

.PHONY: setup
setup:
ifeq ($(OS), Darwin)
	brew install dep
else
	curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
endif
	dep ensure -vendor-only

.PHONY: build
build: ## Build binary
	@echo ""
	@echo "$(YELLOW)==> Creating binaries for $(VERSION)$(RESET)"
	@if [ -d $(PROD_BUILDS) ]; then rm -rf $(PROD_BUILDS); fi;
	@go fmt
	@gox -ldflags "$(LD_FLAGS) -X main.Version=${VERSION} \
	 -X github.com/testthedocs/redactor/cmd.BuildDate=$(BUILD_DATE) \
	 -X github.com/testthedocs/redactor/cmd.GitCommit=$(GIT_COMMIT)" \
	 -osarch="linux/amd64 darwin/amd64" -output "$(PROD_BUILDS)/{{.Dir}}_{{.OS}}_{{.Arch}}"
	@echo ""
	@echo "$(YELLOW)==> Done ! Binaries for $(VERSION) are created in $(PROD_BUILDS) $(RESET)"

.PHONY: test-build
test-build: ## Creating test builds (binaries) for local testing
	@echo ""
	@echo "$(YELLOW)==> Creating test binaries for $(VERSION)$(RESET)"
	@if [ -d $(TEST_BUILDS) ]; then rm -rf $(TEST_BUILDS); fi;
	@go fmt
	@gox -ldflags "$(LD_FLAGS) -X main.Version=${VERSION} \
	 -X github.com/testthedocs/redactor/cmd.BuildDate=$(BUILD_DATE) \
	 -X github.com/testthedocs/redactor/cmd.GitCommit=$(GIT_COMMIT)" \
	 -osarch="linux/amd64 darwin/amd64" -output "$(TEST_BUILDS)/{{.Dir}}_{{.OS}}_{{.Arch}}"
	@echo ""
	@echo "$(YELLOW)==> Done ! Test binaries for $(VERSION) are created in $(TEST_BUILDS) $(RESET)"

.PHONY: install
install: ## Install test binary locally
	@echo ""
	@echo "$(YELLOW)==> Installing test binary for $(VERSION)$(RESET)"
	go install -ldflags "$(LD_FLAGS) -X main.Version=${VERSION} \
	 -X github.com/testthedocs/redactor/cmd.GitCommit=$(GIT_COMMIT) \
	 -X github.com/testthedocs/redactor/cmd.BuildDate=$(BUILD_DATE)"

$(GOMETALINTER):
	go get -u github.com/alecthomas/gometalinter
	gometalinter --install &> /dev/null

.PHONY: lint
lint: $(GOMETALINTER)
	gometalinter ./... --vendor

.PHONY: docs
docs: ## Building docs locally
	@docker run -v `pwd`/docs:/build/docs testthedocs/ttd-sphinx html
