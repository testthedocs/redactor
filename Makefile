# The shell we use
SHELL := /bin/bash

# Get version form VERSION
VERSION := $(shell cat VERSION)
DOCKER := $(bash docker)

# We like colors
# From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`

# Add the following 'help' target to your Makefile
# # And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: html
html: ## Building HTML for prod deploy
	@echo ""
	@echo "$(YELLOW)==> Building HTML  ....$(RESET)"
	@rm -rf docs/_build
	@cp VERSION docs
	docker run --rm -v "${PWD}/docs":/build/docs:rw -u "$$(id -u)":"$$(id -g)" testthedocs/rdc:latest html
	@rm docs/VERSION

.PHONY: docs
docs: ## Building rd-docs container
	@echo ""
	@echo "$(YELLOW)==> Building Docs Container  ....$(RESET)"
	docker build -t rd-docs:$(VERSION) --rm -f tools/rd-docs/Dockerfile .
	docker tag rd-docs:$(VERSION) rd-docs:latest

.PHONY: build-docs
build-docs: check-release-version html docs ## Building docs and container

.PHONY: check-release-version
check-release-version: ## Check Release Version
	@if docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(RED)$(NAME) version $(VERSION) is already build !$(RESET)"; false; fi
