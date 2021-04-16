#!/usr/bin/env bash

set -euo pipefail

# create tun device
mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
  mknod /dev/net/tun c 10 200
fi
chmod 666 /dev/net/tun

# get server ip
export PROTONVPN_IP=$(jq -r ".LogicalServers[] | select(.Name == \"${PROTONVPN_SERVER}\").Servers[0].EntryIP" /opt/servers.json)
if [ -z "$PROTONVPN_IP" ]; then
  echo "not found server ${PROTONVPN_SERVER}"
  exit 1
fi

# generate auth file
echo "${PROTONVPN_USERNAME}" >> /opt/auth.txt
echo "${PROTONVPN_PASSWORD}" >> /opt/auth.txt
chmod 600 /opt/auth.txt

/opt/killswitch.sh

/usr/sbin/openvpn --config /opt/any.ovpn --auth-user-pass /opt/auth.txt --remote ${PROTONVPN_IP} ${PROTONVPN_PORT} ${PROTONVPN_PROTOCOL} --dev proton0 --dev-type tun --auth-nocache
