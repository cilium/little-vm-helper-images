#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg \
    https://packages.cloud.google.com/apt/doc/apt-key.gpg

chmod 0644 /usr/share/keyrings/kubernetes-archive-keyring.gpg

cat > /etc/apt/sources.list.d/kubernetes.list <<EOF
deb [arch=amd64 signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update --quiet && apt-get install --quiet --yes --no-install-recommends \
    kubectl
