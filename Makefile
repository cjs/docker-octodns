NAMESPACE := cjs
PROJECT_NAME := octodns

VERSION := $(shell cat VERSION)
TAG_PREFIX :=

build-octodns:
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	docker build -t $(TAG) --build-arg VERSION=$(VERSION) .

test-octodns: build-octodns
	$(eval VERSION := $(shell cat VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	bash test.sh $(TAG)


push-octodns:
	docker tag cjs/octodns:v0.9.5 csteinbe/docker-octodns:v0.9.5
	docker push csteinbe/docker-octodns:v0.9.5
