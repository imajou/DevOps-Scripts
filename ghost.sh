#!/bin/sh

GHOST_DOMAIN=example.com

docker run -d --name=ghost-$GHOST_DOMAIN --restart=always \
-e VIRTUAL_PORT=2368 -e VIRTUAL_HOST=$GHOST_DOMAIN -e url="https://$GHOST_DOMAIN" ghost
