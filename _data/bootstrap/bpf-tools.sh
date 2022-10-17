#!/usr/bin/env bash

set -eu

CILIUM_VERSION=v1.12.2
WORKDIR=/tmp/workspace
OCI_DIR=cilium-oci
UNPACKED_DIR=cilium-unpacked

apt-get update
apt-get -y install skopeo oci-image-tool

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
mv $UNPACKED_DIR/bin/clang $UNPACKED_DIR/bin/llc /bin

# libbpf
rm /usr/lib/x86_64-linux-gnu/libbpf* # cleanup pre-installed libbpf
mv $UNPACKED_DIR/usr/lib/libbpf* /usr/lib/x86_64-linux-gnu

# bpftool
mv $UNPACKED_DIR/usr/local/bin/bpftool /bin

# iproute2
rm -f `which ip` # cleanup pre-installed ip
rm -f `which tc` # cleanip pre-installed tc
mv $UNPACKED_DIR/usr/local/bin/ip /sbin
mv $UNPACKED_DIR/usr/local/bin/tc /sbin

# Cleanup
popd
rm -rf $WORKDIR
apt-get -y --purge remove skopeo oci-image-tool
apt-get clean

# Test
clang --version
llc --version
bpftool version
ip -V
tc -V
