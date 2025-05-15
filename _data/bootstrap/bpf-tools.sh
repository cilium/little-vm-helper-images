#!/usr/bin/env bash

set -eu

# renovate: datasource=github-releases depName=cilium/cilium
CILIUM_VERSION=v1.17.4
WORKDIR=/tmp/workspace
OCI_DIR=cilium-oci
UNPACKED_DIR=cilium-unpacked

apt-get update
apt-get -y --no-install-recommends install skopeo oci-image-tool

mkdir $WORKDIR
pushd $WORKDIR

#
# Extract BPF-related tools from Cilium container image. We don't use
# docker run here because we are running inside the chroot and it's
# a bit tricky to make it work. So, we simply use skopeo and
# oci-image-tool here.
#

# Fetch Cilium container image
skopeo copy docker://quay.io/cilium/cilium:$CILIUM_VERSION oci:$OCI_DIR

# Unpack Cilium image into local file system
digest=$(skopeo inspect --format "{{.Digest}}" oci:$OCI_DIR)
oci-image-tool unpack --ref digest=$digest $OCI_DIR $UNPACKED_DIR

# LLVM/Clang
mv $UNPACKED_DIR/usr/local/bin/clang $UNPACKED_DIR/usr/local/bin/llc /bin

# bpftool
mv $UNPACKED_DIR/usr/local/bin/bpftool /bin

# Cleanup
popd
rm -rf $WORKDIR
apt-get -y --purge remove skopeo oci-image-tool
apt-get clean
rm -rf /var/lib/apt/lists/*

# Test
clang --version
llc --version
bpftool version
