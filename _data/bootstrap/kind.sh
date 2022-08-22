#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

GOBIN=/usr/local/bin go install sigs.k8s.io/kind@v0.14.0
