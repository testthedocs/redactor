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
