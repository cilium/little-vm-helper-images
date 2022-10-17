OCIORG 			?= quay.io/lvh-images
LVH             ?= $(OCIORG)/lvh
ROOT_BUILDER    ?= $(OCIORG)/root-builder
ROOT_IMAGES     ?= $(OCIORG)/root-images
KERNEL_BUILDER  ?= $(OCIORG)/kernel-builder
KERNEL_IMAGES	?= $(OCIORG)/kernel-images
KIND_IMAGES		?= $(OCIORG)/kind
COMPLEXITY_TEST_IMAGES		?= $(OCIORG)/complexity-test

KERNEL_VERSIONS=4.19 5.4 5.10 5.15 bpf-next

DOCKER ?= docker
export DOCKER_BUILDKIT = 1

.PHONY: all
all:
	@echo "Available targets:"
	@echo "  images_builder:   build root fs builder images"
	@echo "  kernels_builder:  build root kernel builder images"
	@echo "  images:           build root fs images"
	@echo "  kernels:          build root kernel images"
	@echo "  kind:             build root kind images"
	@echo "  complexity-test:  build root complexity-test images"

.PHONY: images_builder
images_builder:
	$(DOCKER) build -f dockerfiles/root-builder -t $(ROOT_BUILDER) .

.PHONY: images
images: images_builder
	$(DOCKER) build -f dockerfiles/root-images  -t $(ROOT_IMAGES)  .

.PHONY: kernels_builder
kernels_builder:
	$(DOCKER) build -f dockerfiles/kernel-builder -t $(KERNEL_BUILDER) .

.PHONY: kernels
kernels: kernels_builder
	for v in $(KERNEL_VERSIONS) ; do \
		$(DOCKER) build --no-cache --build-arg KERNEL_VER=$$v -f dockerfiles/kernel-images -t $(KERNEL_IMAGES):$$v . ; \
	done

.PHONY: kind
kind: kernels images
	for v in $(KERNEL_VERSIONS) ; do \
		 $(DOCKER) build --no-cache --build-arg KERNEL_VER=$$v -f dockerfiles/kind-images -t $(KIND_IMAGES):$$v . ; \
	done

.PHONY: complexity-test
complexity-test: kernels images
	for v in $(KERNEL_VERSIONS) ; do \
		 $(DOCKER) build --no-cache --build-arg KERNEL_VER=$$v -f dockerfiles/complexity-test-images -t $(COMPLEXITY_TEST_IMAGES):$$v . ; \
	done
