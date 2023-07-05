
This repository contains [little-vm-helper](https://github.com/cilium/little-vm-helper)
configuration files and dockerfiles for building kernel and rootfs images. The latter are stored in
OCI images (https://quay.io/organization/lvh-images) so that they can be used in
testing/development.

## Use

The easiest way to use this repository is via the Makefile, which performs the builds in docker
containers that include all the necessary dependnecies. `make` without arguments will print a list
of targets. Alternatively, [lvh](https://github.com/cilium/little-vm-helper/) can be used directly,
which is  faster but requres the necessary tools (e.g., guestfs-tools) to be installed in the host.

### Build and start a VM using Makefile

The Makefile targets will produce docker images that contain the generated root image(s). The
commands below will generate the root images, extract the base image, and use it to boot a VM.

```
$ make images
...
 => => writing image sha257:96a86e6ebb38238569c007491c3e86a056340ceb9e4a3e66959bfa6a6ca8f8a0
 => => naming to quay.io/lvh-images/root-images
$ c=$(docker create sha256:96a86e6ebb38238569c007491c3e86a056340ceb9e4a3e66959bfa6a6ca8f8a0)
$ docker cp $c:/data/images/kind_bpf-next.qcow2.zst /tmp
$ zstd --decompress /tmp/base.qcow2.zst
$ lvh run --host-mount $(pwd) --image /tmp/base.qcow2
```

### Build and start a VM with lvh

The command below will directly buid the base image, and use it to boot a VM.

```
$ lvh images --dir _data build --image base.qcow2
$ lvh  run --host-mount $(pwd) --image _data/images/base.qcow2
```

## Configuration files

### LVH configuration (under \_data)

- [images.json](_data/images.json) is the configuration for building root images. There are two root images:
  base and kind. The former is intended for simple tests (e.g., [tetragon unit
  tests](https://github.com/cilium/tetragon/tree/main/tests/vmtests)) and the latter
  for kind-based tests.

- [kernels.json](_data/kernels.json) is the configuration for the various kernels.

### Dockerfiles

- [kernel-builder](./dockerfiles/kernel-builder) builds a container for building kernel images
  images
- [kernel-images](./dockerfiles/kernel-images) builds a container with the kernel images
- [root-builder](./dockerfiles/root-builder) builds a container for building root images
- [root-images](./dockerfiles/root-images) builds a container with all the root images
- [kind-images](./dockerfiles/kind-images) builds kernel-specific version of the kind image
- [complexity-test-images](./dockerfiles/complexity-test-images) builds kernel-specific versions of
  the complexity-test-image
