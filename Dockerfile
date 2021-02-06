FROM ubuntu:focal

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y dante-server openvpn bash openresolv iptables curl wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install htop iputils-ping

COPY danted.conf /etc/
COPY danted.sh /opt/
RUN chmod a+x /opt/danted.sh

COPY any.ovpn /opt/
COPY config.env /opt/
COPY auth.txt /opt/

COPY update-resolv-conf /etc/openvpn/
RUN chmod +x /etc/openvpn/update-resolv-conf

# add empty dns config
COPY resolv.conf /opt/

# should not leak
#RUN cat /etc/hosts && true

# disable ipv6
COPY disable_ipv6.conf /etc/sysctl.d/

# block ipv6
COPY block_ipv6.sh /opt/
RUN chmod a+x /opt/block_ipv6.sh

COPY entrypoint.sh /opt/
RUN chmod a+x /opt/entrypoint.sh

COPY dns.sh /opt/
RUN chmod a+x /opt/dns.sh

COPY killswitch.sh /opt/
RUN chmod a+x /opt/killswitch.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
