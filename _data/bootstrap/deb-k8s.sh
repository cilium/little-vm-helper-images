#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

# renovate: datasource=github-releases depName=kubernetes/kubernetes
KUBECTL_VERSION=1.29.3
ARCH=$(dpkg --print-architecture)

curl -LO "https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/$ARCH/kubectl"

# validate the binary
curl -LO "https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/$ARCH/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# remove temp files
rm kubectl kubectl.sha256
