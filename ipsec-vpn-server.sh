#!/bin/sh

IPSEC_VPN_KEY=abcdefghigklmnopqrstuvwx
IPSEC_VPN_USER=admin
IPSEC_VPN_PASS=password

docker pull hwdsl2/ipsec-vpn-server
docker run \
    --name ipsec-vpn-server \
    -e VPN_IPSEC_PSK=$IPSEC_VPN_KEY \
    -e VPN_USER=$IPSEC_VPN_USER \
    -e VPN_PASSWORD=$IPSEC_VPN_PASS \
    -e VPN_DNS_SRV1=1.1.1.1 \
    -e VPN_DNS_SRV2=1.0.0.1 \
    --restart=always \
    -p 500:500/udp \
    -p 4500:4500/udp \
    -v /lib/modules:/lib/modules:ro \
    -d --privileged \
    hwdsl2/ipsec-vpn-server