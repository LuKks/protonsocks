#!/usr/bin/env bash

set -euo pipefail

# create tun device
mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
  mknod /dev/net/tun c 10 200
fi
chmod 666 /dev/net/tun

# get server ip
echo "searching server ip for ${PVPN_SERVER}"
export PVPN_IP=$(jq -r "[.LogicalServers[] | select(.Status == 1) | select(.Name == \"${PVPN_SERVER}\").Servers[] | select(.Status == 1)][0].EntryIP" /opt/servers.json)
if [ -z "$PVPN_IP" ] || [ "$PVPN_IP" == "null" ]; then
  echo "not found available server with status 1 named ${PVPN_SERVER}"
  echo "rebuild image in case you know the server is actually available"
  exit 1
fi
echo "found server ip ${PVPN_IP} (EntryIP)"

# generate auth file
echo "${PVPN_USERNAME}" >> /opt/auth.txt
echo "${PVPN_PASSWORD}" >> /opt/auth.txt
chmod 600 /opt/auth.txt

# empty dns
echo "" > /etc/resolv.conf

/usr/sbin/openvpn --config /opt/any.ovpn --auth-user-pass /opt/auth.txt --remote ${PVPN_IP} ${PVPN_PORT} ${PVPN_PROTOCOL} --dev proton0 --dev-type tun --auth-nocache
