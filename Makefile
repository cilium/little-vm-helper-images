
OCIORG ?= quay.io/lvh-images
LVH           ?= $(OCIORG)/lvh
ROOT_BUILDER  ?= $(OCIORG)/root-builder
ROOT_IMAGES   ?= $(OCIORG)/root-images
DOCKER ?= docker

.PHONY: images
images:
	$(DOCKER) build -f dockerfiles/root-builder -t $(ROOT_BUILDER) .
	$(DOCKER) build -f dockerfiles/root-images  -t $(ROOT_IMAGES)  .
