#!/usr/bin/env bash

export $(cat /opt/config.env)

/opt/killswitch.sh

/usr/sbin/openvpn --config /opt/any.ovpn --auth-user-pass /opt/auth.txt --remote ${PROTONVPN_IP} ${PROTONVPN_PORT} ${PROTONVPN_PROTOCOL} --dev proton0 --dev-type tun --auth-nocache
