#!/bin/bash
set -e

if ! pgrep -x "danted" > /dev/null; then
    danted -D -N 10
fi

#if ! ip link show proton0 > /dev/null; then
# echo "Failed to bring up VPN :("
# exit 1
#fi
