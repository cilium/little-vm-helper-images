#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

mkdir /host

config_path="/etc/fstab"

cat > "$config_path" <<EOF
host_mount  /host  9p  trans=virtio,rw,nofail 0  0
/dev/root   /   ext4    errors=remount-ro   0   1

EOF

chmod 644 "$config_path"
