FROM ubuntu:focal

# default proton settings
ENV PVPN_USERNAME=
ENV PVPN_PASSWORD=
ENV PVPN_SERVER=CH-UK#1
ENV PVPN_PORT=443
ENV PVPN_PROTOCOL=tcp

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y dante-server openvpn bash openresolv curl jq

# get servers list
RUN curl https://api.protonmail.ch/vpn/logicals > /opt/servers.json

COPY danted.conf /etc/
COPY danted.sh /opt/
RUN chmod a+x /opt/danted.sh

COPY any.ovpn /opt/

COPY update-resolv-conf /etc/openvpn/
RUN chmod +x /etc/openvpn/update-resolv-conf

COPY disable_ipv6.conf /etc/sysctl.d/

COPY entrypoint.sh /opt/
RUN chmod a+x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
