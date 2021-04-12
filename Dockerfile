FROM ubuntu:focal

# default server
ENV PROTONVPN_SERVER=AR#7
ENV PROTONVPN_PORT=443
ENV PROTONVPN_PROTOCOL=tcp

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y dante-server openvpn bash openresolv iptables curl jq

COPY danted.conf /etc/
COPY danted.sh /opt/
RUN chmod a+x /opt/danted.sh

COPY any.ovpn /opt/
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

# get servers list
RUN curl https://api.protonmail.ch/vpn/logicals > /opt/servers.json

ENTRYPOINT ["/opt/entrypoint.sh"]
