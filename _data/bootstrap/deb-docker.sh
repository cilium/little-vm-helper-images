#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

curl -fsSL https://download.docker.com/linux/debian/gpg | \
      gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

chmod 0644 /usr/share/keyrings/docker-archive-keyring.gpg

cat > /etc/apt/sources.list.d/docker.list <<EOF
deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable
EOF

apt-get update --quiet && apt-get install --quiet --yes --no-install-recommends \
    docker-ce docker-ce-cli containerd.io

# for iptables 1.8.8
update-alternatives --set iptables /usr/sbin/iptables-nft
update-alternatives --set ip6tables /usr/sbin/ip6tables-nft
