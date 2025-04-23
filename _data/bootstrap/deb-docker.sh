#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

curl -fsSL https://download.docker.com/linux/debian/gpg | \
      gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

chmod 0644 /usr/share/keyrings/docker-archive-keyring.gpg

cat > /etc/apt/sources.list.d/docker.list <<EOF
deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bookworm stable
EOF

apt-get update --quiet && apt-get install --quiet --yes --no-install-recommends \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# for iptables 1.8.8
update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

mkdir -p /etc/systemd/system/docker.service.d

cat <<EOF >> /etc/systemd/system/docker.service.d/socket.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375
EOF

systemctl daemon-reload
systemctl restart docker
