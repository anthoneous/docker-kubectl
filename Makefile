KUBEVERSION:=1.22.17
IMAGEREPO:=ghcr.io/anthoneous/kubectl
GITHUB_USER:=anthoneous

define KUBECTL
docker run --rm \
	-v $(HOME)/.kube:/root/.kube \
	$(IMAGEREPO):$(KUBEVERSION) \
	kubectl
endef

.DEFAULT_GOAL:= help

.PHONY: help
help: ## Display this help
	@echo "Usage:\n make <target>\n\nTargets:" && \
	grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | \
	sed 's/\(.*\):.*##\(.*\)/  \1\t\t\2/'

.PHONY: all
all: login build test push

.PHONY: build
build: ## Build the docker image
	docker build \
	--build-arg KUBEVERSION=$(KUBEVERSION) \
	-t $(IMAGEREPO):$(KUBEVERSION) \
	.

.PHONY: test
test: ## Run the kubectl version command
	$(KUBECTL) version

.PHONY: push
push: ## Push the docker image to the registry
	docker push $(IMAGEREPO):$(KUBEVERSION)

.PHONY: login
login: ## Login to the docker registry
	echo $(GITHUB_TOKEN) | docker login ghcr.io -u $(GITHUB_USER) --password-stdin