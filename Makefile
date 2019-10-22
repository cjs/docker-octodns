NAMESPACE := cjs
PROJECT_NAME := octodns
TAG_PREFIX :=

dive-octodns: build-octodns
	$(eval VERSION := $(shell cat VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	dive $(TAG)

build-octodns: 
	$(eval VERSION := $(shell cat VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	docker build -t $(TAG) --build-arg VERSION=$(VERSION) .

test-octodns: build-octodns
	$(eval VERSION := $(shell cat VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	bash test.sh $(TAG)

publish-octodns: test-octodns
	$(eval VERSION := $(shell cat VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	docker push $(TAG)
