
OCIORG ?= quay.io/lvh-images
LVH             ?= $(OCIORG)/lvh
ROOT_BUILDER    ?= $(OCIORG)/root-builder
ROOT_IMAGES     ?= $(OCIORG)/root-images
KERNEL_BUILDER  ?= $(OCIORG)/kernel-builder
KERNEL_IMAGES  ?= $(OCIORG)/kernel-images
DOCKER ?= docker

KERNEL_VERSIONS=4.19 5.4 5.10 bpf-next

.PHONY: all
all: images kernels

.PHONY: images
images:
	$(DOCKER) build -f dockerfiles/root-builder -t $(ROOT_BUILDER) .
	$(DOCKER) build -f dockerfiles/root-images  -t $(ROOT_IMAGES)  .

.PHONY: kernels
kernels:
	$(DOCKER) build -f dockerfiles/kernel-builder -t $(KERNEL_BUILDER) .
	for v in $(KERNEL_VERSIONS) ; do \
		$(DOCKER) build --build-arg KERNEL_VER=$$v -f dockerfiles/kernel-image -t $(KERNEL_IMAGES):$$v . ; \
	done
