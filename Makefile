# Variables for commonly reused information
KUBEVERSION := 1.22.17
IMAGEREPO := ghcr.io/anthoneous/kubectl
GITHUB_USER := anthoneous
DOCKER_ARGS := --rm -v $(HOME)/.kube:/root/.kube
DOCKER_IMAGE := $(IMAGEREPO):$(KUBEVERSION)

# Define a reusable kubectl command using Docker
define KUBECTL
docker run $(DOCKER_ARGS) $(DOCKER_IMAGE) kubectl
endef

# Default target to show the help menu
.DEFAULT_GOAL := help

# Help target: Display all available targets and their descriptions
.PHONY: help
help: ## Display this help
	@echo "Usage:\n make <target>\n\nTargets:" && \
	grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | \
	sed 's/\(.*\):.*##\(.*\)/  \1\t\t\2/'

# Composite target to run all the essential steps in one go
.PHONY: all
all: login build test push

# Build the Docker image using the Kubernetes version variable
.PHONY: build
build: ## Build the docker image
	docker build \
	--build-arg KUBEVERSION=$(KUBEVERSION) \
	-t $(IMAGEREPO):$(KUBEVERSION) \
	.

# Run the kubectl version command to test the Dockerized kubectl
.PHONY: test
test: ## Run the kubectl version command
	$(KUBECTL) version

# Push the Docker image to the container registry
.PHONY: push
push: ## Push the docker image to the registry
	docker push $(IMAGEREPO):$(KUBEVERSION)

# Login to the Docker registry using GitHub token
.PHONY: login
login: ## Login to the docker registry
	echo $(GITHUB_TOKEN) | docker login ghcr.io -u $(GITHUB_USER) --password-stdin