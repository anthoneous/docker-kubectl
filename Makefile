KUBEVERSION:=1.10.7
IMAGEREPO:=ghcr.io/anthoneous/kubectl
GITHUB_USER:=anthoneous

define KUBECTL
docker run --rm \
	-v $(HOME)/.kube:/root/.kube \
	$(IMAGEREPO):$(KUBEVERSION) \
	kubectl
endef


.PHONY: all
all: login build test push

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

.PHONY: login
login:
	echo $(GITHUB_TOKEN) | docker login ghcr.io -u $(GITHUB_USER) --password-stdin