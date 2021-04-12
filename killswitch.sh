export $(cat /opt/config.env)

# empty dns
echo "" > /etc/resolv.conf

# clear
iptables -F

# drop all traffic
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# allow only from/to specific proxy server
iptables -A INPUT -s ${PROTONVPN_IP} -p ${PROTONVPN_PROTOCOL} -m ${PROTONVPN_PROTOCOL} --sport ${PROTONVPN_PORT} -j ACCEPT
iptables -A OUTPUT -d ${PROTONVPN_IP} -p ${PROTONVPN_PROTOCOL} -m ${PROTONVPN_PROTOCOL} --dport ${PROTONVPN_PORT} -j ACCEPT

# allow proton0, tcp, 443
# this part is in update-resolv-conf up:
#iptables -A INPUT -i lo -j ACCEPT
#iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -i proton0 -j ACCEPT
iptables -A OUTPUT -o proton0 -j ACCEPT
iptables -A INPUT -i proton0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -o proton0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i proton0 -p tcp -m tcp --sport 443 -j ACCEPT
iptables -A OUTPUT -o proton0 -p tcp -m tcp --dport 443 -j ACCEPT

# allow internal traffic
default_nic=`ip route show | grep default` # default via 172.18.0.1 dev eth0 ...
default_nic=(${default_nic//;/ }) # split by space
default_nic=(${default_nic[4]}) # eth0
echo "default_nic: ${default_nic}"

local_network=`ip addr show ${default_nic} | grep inet` # inet 172.18.0.2/16 brd ...
local_network=(${local_network//;/ }) # split by space
local_network=(${local_network[1]}) # 172.18.0.2/16
echo "local_network: ${local_network}"

iptables -A INPUT -i ${default_nic} -s ${local_network} -j ACCEPT
iptables -A OUTPUT -o ${default_nic} -d ${local_network} -j ACCEPT
