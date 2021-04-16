FROM ubuntu:focal

# default proton settings
ENV PROTONVPN_USERNAME=
ENV PROTONVPN_PASSWORD=
ENV PROTONVPN_SERVER=CH-MX#1
ENV PROTONVPN_PORT=443
ENV PROTONVPN_PROTOCOL=tcp

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y dante-server openvpn bash openresolv iptables curl jq

# get servers list
RUN curl https://api.protonmail.ch/vpn/logicals > /opt/servers.json

COPY danted.conf /etc/
COPY danted.sh /opt/
RUN chmod a+x /opt/danted.sh

COPY any.ovpn /opt/

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
