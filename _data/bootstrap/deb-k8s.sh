#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat > /etc/apt/sources.list.d/kubernetes.list <<EOF
deb [arch=amd64] https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update --quiet && apt-get install --quiet --yes --no-install-recommends \
    kubectl
