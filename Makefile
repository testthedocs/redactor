# The shell we use
SHELL := /bin/bash

# Get version form VERSION
VERSION := $(shell cat VERSION)
DOCKER := $(bash docker)

# Name of container
DOCS_CT_NAME = testthedocs/rd-docs

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

.PHONY: docs-html
docs-html: ## Building HTML for prod deploy
	@echo ""
	@echo "$(YELLOW)==> Building HTML  ....$(RESET)"
	@rm -rf docs/_build
	@cp VERSION docs
	docker run --rm -v "${PWD}/docs":/build/docs:rw -u "$$(id -u)":"$$(id -g)" testthedocs/rdc:latest html
	@rm docs/VERSION

.PHONY: docs-container
docs-container: ## Building rd-docs container
	@echo ""
	@echo "$(YELLOW)==> Building Docs Container  ....$(RESET)"
	docker build -t $(DOCS_CT_NAME):$(VERSION) --rm -f tools/rd-docs/Dockerfile .
	docker tag $(DOCS_CT_NAME):$(VERSION) rd-docs:latest

.PHONY: docs-release
docs-release: check-release-version docs-html docs-container docs-upload ## Building docs and container

.PHONY: check-release-version
check-release-version: ## Check Release Version
	@if docker images $(DOCS_CT_NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(RED)$(DOCS_CT_NAME) version $(VERSION) is already build !$(RESET)"; false; fi

.PHONY: docs-upload
docs-upload: ## Pushing container to docker hub
	docker push $(DOCS_CT_NAME):$(VERSION)
	docker push $(DOCS_CT_NAME):latest
