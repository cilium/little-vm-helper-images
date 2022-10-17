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

## Use

The easiest way to use this repository is via the Makefile, which uses docker. `make` without
arguments will print a list of targets. Alternatively, https://github.com/cilium/little-vm-helper/
can be used directly, which is  faster but requres the necessary tools (e.g., guestfs-tools) to be
installed in the host.


### Build and start a VM using Makefile

The Makefile targets will produce docker images that contain the generated root image(s). The
commands below will generate the root images, extract the base image, and use it to boot a VM.

```
$ make images
...
 => => writing image sha257:96a86e6ebb38238569c007491c3e86a056340ceb9e4a3e66959bfa6a6ca8f8a0
 => => naming to quay.io/lvh-images/root-images
$ c=$(docker create sha256:96a86e6ebb38238569c007491c3e86a056340ceb9e4a3e66959bfa6a6ca8f8a0)
$ docker cp $c:/data/images/base.qcow2.zst /tmp
$ zstd --decompress /tmp/base.qcow2.zst
$ lvh run --host-mount $(pwd) --image /tmp/base.qcow2
```

### Build and start a VM with lvh

The command below will directly buid the base image, and use it to boot a VM.

```
$ lvh images --dir _data build --image base.qcow2
$ lvh  run --host-mount $(pwd) --image _data/images/base.qcow2
```
