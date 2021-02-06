#!/usr/bin/env bash

set -euo pipefail

# clear rules
ip6tables -F
ip6tables -X
for table in nat mangle raw security; do
    for opt in -F -X; do
        ip6tables -t "$table" "$opt"
    done
done

# drop all traffic
for chain in INPUT OUTPUT FORWARD; do
    ip6tables -P "$chain" DROP
done

ip6tables -A INPUT -i proton0 -j DROP
ip6tables -A OUTPUT -o proton0 -j DROP

default_nic=`ip route show | grep default` # default via 172.18.0.1 dev eth0 ...
default_nic=(${default_nic//;/ }) # split by space
default_nic=(${default_nic[4]}) # eth0

ip6tables -A INPUT -i ${default_nic} -j DROP
ip6tables -A OUTPUT -o ${default_nic} -j DROP
