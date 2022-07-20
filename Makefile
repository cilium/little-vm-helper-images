
OCIORG ?= quay.io/lvh-images
LVH             ?= $(OCIORG)/lvh
ROOT_BUILDER    ?= $(OCIORG)/root-builder
ROOT_IMAGES     ?= $(OCIORG)/root-images
KERNEL_BUILDER  ?= $(OCIORG)/kernel-builder
DOCKER ?= docker

.PHONY: all
all: images kernels

.PHONY: images
images:
	$(DOCKER) build -f dockerfiles/root-builder -t $(ROOT_BUILDER) .
	$(DOCKER) build -f dockerfiles/root-images  -t $(ROOT_IMAGES)  .

.PHONY: kernels
kernels:
	$(DOCKER) build -f dockerfiles/kernel-builder -t $(KERNEL_BUILDER) .
