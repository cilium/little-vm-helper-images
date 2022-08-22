#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

config_path="/etc/ssh/sshd_config"

cat > "$config_path" <<EOF
# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

PasswordAuthentication yes
PermitEmptyPasswords yes
PermitRootLogin yes
PubkeyAuthentication no
PrintMotd no

# Allow client to pass locale environment variables
AcceptEnv LANG LC_*

# override default of no subsystems
Subsystem       sftp    /usr/lib/openssh/sftp-server

EOF

chmod 644 "$config_path"
