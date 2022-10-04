KUBEVERSION:=1.10.7
IMAGEREPO:=ghcr.io/anthoneous/kubectl

define KUBECTL
docker run --rm \
	-v $(HOME)/.kube:/root/.kube \
	$(IMAGEREPO):$(KUBEVERSION) \
	kubectl
endef


.PHONY: all
all: build test push

.PHONY: build
build:
	docker build \
	--build-arg KUBEVERSION=$(KUBEVERSION) \
	-t $(IMAGEREPO):$(KUBEVERSION) \
	.

.PHONY: test
test: 
	$(KUBECTL) version

.PHONY: push
push:
	docker push $(IMAGEREPO):$(KUBEVERSION)