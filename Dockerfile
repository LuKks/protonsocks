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

# should not leak
#RUN cat /etc/hosts && true

COPY disable_ipv6.conf /etc/sysctl.d/

COPY entrypoint.sh /opt/
RUN chmod a+x /opt/entrypoint.sh

COPY killswitch.sh /opt/
RUN chmod a+x /opt/killswitch.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
