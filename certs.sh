#!/bin/sh

CERTBOT_DOMAIN=example.com

docker stop nginx-proxy-$CERTBOT_DOMAIN || true && docker rm nginx-proxy-$CERTBOT_DOMAIN || true

docker run --rm -ti -v letsencrypt-$CERTBOT_DOMAIN:/etc/letsencrypt certbot/certbot \
certonly -d "$CERTBOT_DOMAIN" -d "*.$CERTBOT_DOMAIN" \
--agree-tos --email admin@$CERTBOT_DOMAIN \
--manual --preferred-challenges dns

docker run --rm -ti -e CERTBOT_DOMAIN=$CERTBOT_DOMAIN \
-v letsencrypt-$CERTBOT_DOMAIN:/letsencrypt -v proxy-certs-$CERTBOT_DOMAIN:/proxy-certs \
alpine:latest sh -c \
"cp /letsencrypt/live/$CERTBOT_DOMAIN/privkey.pem /proxy-certs/$CERTBOT_DOMAIN.key; \
cp /letsencrypt/live/$CERTBOT_DOMAIN/fullchain.pem /proxy-certs/$CERTBOT_DOMAIN.crt"

docker network create -d bridge nginx-proxy-bridge-$CERTBOT_DOMAIN || true

docker run -d --name nginx-proxy-$CERTBOT_DOMAIN --restart always \
--network="nginx-proxy-bridge-$CERTBOT_DOMAIN" -e ENABLE_IPV6=true \
-p 80:80 -p 443:443 \
-v /var/run/docker.sock:/tmp/docker.sock:ro \
-v letsencrypt-$CERTBOT_DOMAIN:/letsencrypt \
-v proxy-certs-$CERTBOT_DOMAIN:/etc/nginx/certs \
jwilder/nginx-proxy:alpine
