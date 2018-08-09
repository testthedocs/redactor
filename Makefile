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
APP_NAME=redactor

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: docs-build
docs-build: ## Builds HTML of the docs
	@docker run -it --rm -v `pwd`:/docs wundertax/mkdocs:latest build

.PHONY: docs-serve
docs-serve: ## Starts docs in serve mode
	@docker run -it --rm -p 8000:8000 -v `pwd`:/docs wundertax/mkdocs:latest serve

.PHONY: docs-help
docs-help: ## Shows docs-help
	@docker run -it --rm -v `pwd`:/docs wundertax/mkdocs:latest help

# We use https://github.com/github-changelog-generator/github-changelog-generator as Docker Container.
# This is to make sure we have the same change-log setup through all repositories, even if that means we use ruby here :)
.PHONY: changelog
changelog: ## Generate changelog
	@echo ""
	@echo "$(YELLOW)==> Generating Change-log..$(RESET)"
	@docker run -it --rm -v "$(pwd)":/usr/local/src/your-app ferrarimarco/github-changelog-generator wundertax/bb-8 --token $(GITHUB_TOKEN)
	@echo ""

.PHONY: test-release
test-release: ## Builds binary packages for testing
	@echo ""
	@echo "$(YELLOW)==> Running fmt locally ...$(RESET)"
	@go fmt
	@echo "$(YELLOW)==> Creating binaries for $(APP_NAME) $(VERSION) please wait ....$(RESET)"
	@if [ -d pkg ]; then rm -rf pkg; fi;
	@gox -osarch="darwin/amd64" -output "pkg/{{.Dir}}_{{.OS}}_{{.Arch}}"

$(GOMETALINTER):
	go get -u github.com/alecthomas/gometalinter
	gometalinter --install &> /dev/null

.PHONY: lint
lint: $(GOMETALINTER)
	gometalinter ./... --vendor
