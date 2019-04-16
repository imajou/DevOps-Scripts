#!/bin/sh

MTPROTO_SECRET_1=1234567890abcdef1234567890abcdef
MTPROTO_SECRET_2=abcdef1234567890abcdef1234567890
MTPROTO_PORT=50777

docker pull alexdoesh/mtproxy
docker run -d \
    -p $MTPROTO_PORT:443 \
    --name=mtproxy \
    --restart=always \
    -e SECRET=$MTPROTO_SECRET_1,$MTPROTO_SECRET_2 \
    -v ~/mtproxy:/data \
    alexdoesh/mtproxy:latest