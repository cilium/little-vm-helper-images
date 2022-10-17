This repository contains [little-vm-helper](https://github.com/cilium/little-vm-helper)
configuration files and dockerfiles for building kernel and rootfs images.

## Configuration

- [configuration](_data/images.json) for building root images. There are currently two root images:
  base and kind. The former is intended for simple tests (e.g., [tetragon unit
  tests](https://github.com/cilium/tetragon/tree/main/tests/vmtests)) and the latter
  for more involved tests that use kind.

- [dockerfile](./dockerfiles/root-builder) for a container that can be used to build root images
- [dockerfile](./dockerfiles/root-images) for a container with the base root images
- [dockerfile](./dockerfiles/kind-images) for a container with the kind root images
- [dockerfile](./dockerfiles/kernel-builder) for a container that can be used to build kernels
- [dockerfile](./dockerfiles/kernel-imags) for a container with the kernel images
