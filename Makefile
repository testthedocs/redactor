# The shell we use
SHELL := /bin/bash

# We like colors
# From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`

.PHONY: docs
docs: ## Building Docs for prod deploy
	@echo ""
	@echo "$(YELLOW)==> Building Docs  ....$(RESET)"
	@rm -rf docs/_build
	@cp VERSION docs
	docker run --rm -v "${PWD}/docs":/build/docs:rw -u "$$(id -u)":"$$(id -g)" testthedocs/rdc:latest html
	@rm docs/VERSION

