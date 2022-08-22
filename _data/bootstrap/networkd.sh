#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

config_path="/etc/systemd/network/20-interfaces.network"

cat > "$config_path" <<EOF
[Match]
Name=ens* enp* eth*
[Network]
DHCP=yes

EOF

chmod 644 "$config_path"
