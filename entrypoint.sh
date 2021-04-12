#!/usr/bin/env bash

set -euo pipefail

# get server ip
export PROTONVPN_IP=$(jq -r ".LogicalServers[] | select(.Name == \"${PROTONVPN_SERVER}\").Servers[0].EntryIP" /opt/servers.json)

if [ -z "$PROTONVPN_IP" ]; then
  echo "not found server ${PROTONVPN_SERVER}"
  exit 1
fi

/opt/killswitch.sh

/usr/sbin/openvpn --config /opt/any.ovpn --auth-user-pass /opt/auth.txt --remote ${PROTONVPN_IP} ${PROTONVPN_PORT} ${PROTONVPN_PROTOCOL} --dev proton0 --dev-type tun --auth-nocache
