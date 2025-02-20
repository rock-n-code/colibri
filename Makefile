# VARIABLES

BINARY_FOLDER = $(prefix)/bin
BUILD_FOLDER = .build/release
EXECUTABLE_FILE = colibri

# INPUT ARGUMENTS

prefix ?= /usr/local

# EXECUTABLE MANAGEMENT

build: ## Build the executable from source code
	@swift build -c release --disable-sandbox

install: build ## Install the built executable into the system
	@install -d "$(BINARY_FOLDER)"
	@install "$(BUILD_FOLDER)/$(EXECUTABLE_FILE)" "$(BINARY_FOLDER)"

uninstall: ## Uninstall the built executable from the system
	@rm -rf "$(BINARY_FOLDER)/$(EXECUTABLE_FILE)"

# PACKAGE MANAGEMENT

clean: ## Delete built SPM artifacts from the package
	@swift package clean

outdated: ## List the SPM package dependencies that can be updated
	@swift package update --dry-run

purge: ## Purge the global SPM package repository
	@swift package purge-cache

reset: ## Reset the complete SPM cache/build folder from the package
	@swift package reset

update: ## Update the SPM package dependencies
	@swift package update

wipe: clean reset purge ## Wipe all SPM package dependencies and purge the global SPM repository

# OPEN IDEs

vscode: ## Opens this project with Visual Studio Code
	@code .

xcode: ## Opens this project with Xcode
	@open -a Xcode Package.swift

# HELP

# Output the documentation for each of the defined tasks when `help` is called.
# Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## Prints the written documentation for all the defined tasks
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
