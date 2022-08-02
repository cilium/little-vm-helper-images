This repository contains [little-vm-helper](https://github.com/cilium/little-vm-helper)
configuration files and dockerfiles for building kernel and rootfs images.

- [configuration](_data/images.json) for building root images (single image for now)
- [dockerfile](./dockerfiles/root-builder) for a container that can be used to build root images
- [dockerfile](./dockerfiles/root-images) for a container with the root images

### Issues
 - Using docker build means that there will be no /dev/kvm device in the builder which will
   unfortunately result in slower builds than what you would get otherwise. There are some hints
   in https://github.com/moby/moby/issues/1916 that this might be solved using buildx, but I'm not
   sure how.
