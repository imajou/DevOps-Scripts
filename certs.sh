#!/bin/sh

CERTBOT_DOMAIN=example.com

docker stop nginx-proxy || true && docker rm nginx-proxy || true

docker run --rm -ti -v letsencrypt:/etc/letsencrypt certbot/certbot \
certonly -d "$CERTBOT_DOMAIN" -d "*.$CERTBOT_DOMAIN" \
--agree-tos --email admin@$CERTBOT_DOMAIN \
--manual --preferred-challenges dns

docker run --rm -ti -e CERTBOT_DOMAIN=$CERTBOT_DOMAIN \
-v letsencrypt:/letsencrypt -v proxy-certs:/proxy-certs \
alpine:latest sh -c \
"cp /letsencrypt/live/$CERTBOT_DOMAIN/privkey.pem /proxy-certs/$CERTBOT_DOMAIN.key; \
cp /letsencrypt/live/$CERTBOT_DOMAIN/fullchain.pem /proxy-certs/$CERTBOT_DOMAIN.crt"

docker network create -d bridge nginx-proxy-bridge || true

docker run -d --name nginx-proxy --restart always \
--network="proxy-bridge" -e ENABLE_IPV6=true \
-p 80:80 -p 443:443 \
-v /var/run/docker.sock:/tmp/docker.sock:ro \
-v letsencrypt:/letsencrypt \
-v proxy-certs:/etc/nginx/certs \
jwilder/nginx-proxy:alpine
