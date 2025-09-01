#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

# renovate: datasource=github-releases depName=kubernetes-sigs/kind
KIND_VERSION=v0.30.0

GOBIN=/usr/local/bin go install sigs.k8s.io/kind@${KIND_VERSION}
