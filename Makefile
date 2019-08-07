NAMESPACE := cjs
DOCKER_NAMESPACE := csteinbe
GPR_REPO := cjs/docker-octodns
PROJECT_NAME := octodns
TAG_PREFIX :=

build-octodns:
	$(eval VERSION := $(shell cat VERSION))
	$(eval TAG := $(NAMESPACE)/$(PROJECT_NAME):$(TAG_PREFIX)$(VERSION))
	docker build -t $(TAG) --build-arg VERSION=$(VERSION) .

test-octodns: build-octodns
	$(eval VERSION := $(shell cat VERSION))
	$(eval TAG := $(NAMESPACE)/$(PROJECT_NAME):$(TAG_PREFIX)$(VERSION))
	bash test.sh $(TAG)

publish-octodns-docker: test-octodns
	$(eval VERSION := $(shell cat VERSION))
	$(eval TAG := $(NAMESPACE)/$(PROJECT_NAME):$(TAG_PREFIX)$(VERSION))
	$(eval DOCKER_TAG := $(DOCKER_NAMESPACE)/$(PROJECT_NAME):$(TAG_PREFIX)$(VERSION))
	docker tag $(TAG) $(DOCKER_TAG)
	docker push $(DOCKER_TAG)
	
publish-octodns-gpr: test-octodns
	$(eval VERSION := $(shell cat VERSION))
	$(eval TAG := $(NAMESPACE)/$(PROJECT_NAME):$(TAG_PREFIX)$(VERSION))
	$(eval DOCKER_TAG := $(DOCKER_NAMESPACE)/$(PROJECT_NAME):$(TAG_PREFIX)$(VERSION))
	$(eval GPR_TAG := docker.pkg.github.com/$(GPR_REPO)/$(PROJECT_NAME):$(TAG_PREFIX)$(VERSION))
	docker tag $(TAG) $(GPR_TAG)
	docker push $(GPR_TAG)
