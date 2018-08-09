# The shell we use
SHELL := /bin/bash

BIN_DIR := $(GOPATH)/bin
GOMETALINTER := $(BIN_DIR)/gometalinter

# Dependencies:
# - https://github.com/mitchellh/gox

# We like colors
# From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`

# Get version form VERSION
VERSION := $(shell cat VERSION)
DOCKER := $(bash docker)

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"


.PHONY: test-release
test-release: ## Builds binary packages for testing
	@echo ""
	@echo "$(YELLOW)==> Running fmt locally ...$(RESET)"
	go fmt
	@echo "$(YELLOW)==> Creating binaries for version $(VERSION), please wait ....$(RESET)"
	@if [ -d pkg ]; then rm -rf pkg; fi;
	@gox -osarch="darwin/amd64" -output "pkg/{{.Dir}}_{{.OS}}_{{.Arch}}"

$(GOMETALINTER):
	go get -u github.com/alecthomas/gometalinter
	gometalinter --install &> /dev/null

.PHONY: lint
lint: $(GOMETALINTER)
	gometalinter ./... --vendor
