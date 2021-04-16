#!/usr/bin/env bash

set -euo pipefail

# create tun device
mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
  mknod /dev/net/tun c 10 200
fi
chmod 666 /dev/net/tun

# get server ip
echo "searching server ip for ${PROTONVPN_SERVER}"
export PROTONVPN_IP=$(jq -r "[.LogicalServers[] | select(.Status == 1) | select(.Name == \"${PROTONVPN_SERVER}\").Servers[] | select(.Status == 1)][0].EntryIP" /opt/servers.json)
if [ -z "$PROTONVPN_IP" ] || [ "$PROTONVPN_IP" == "null" ]; then
  echo "not found available server with status 1 named ${PROTONVPN_SERVER}"
  echo "rebuild image in case you know the server is actually available"
  exit 1
fi
echo "found server ip ${PROTONVPN_IP} (EntryIP)"

# generate auth file
echo "${PROTONVPN_USERNAME}" >> /opt/auth.txt
echo "${PROTONVPN_PASSWORD}" >> /opt/auth.txt
chmod 600 /opt/auth.txt

/opt/killswitch.sh

/usr/sbin/openvpn --config /opt/any.ovpn --auth-user-pass /opt/auth.txt --remote ${PROTONVPN_IP} ${PROTONVPN_PORT} ${PROTONVPN_PROTOCOL} --dev proton0 --dev-type tun --auth-nocache
