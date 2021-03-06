#!/bin/sh

MINECRAFT_CONTAINER_NAME=innocraft-vanilla
MINECRAFT_PORT=25565
MINECRAFT_SERVER_NAME="InnoCraft"
MINECRAFT_OPS=
MINECRAFT_MAX_PLAYERS=10
MINECRAFT_DIFFICULTY=normal
MINECRAFT_PVP=false

docker run -d \
    -p 25565:$MINECRAFT_PORT \
    --name $MINECRAFT_CONTAINER_NAME \
    -e MEMORY="1G" \
    -e DIFFICULTY=$MINECRAFT_DIFFICULTY \
    -e MAX_PLAYERS=$MINECRAFT_MAX_PLAYERS \
    -e MAX_WORLD_SIZE=30000 \
    -e SERVER_NAME=$MINECRAFT_SERVER_NAME \
    -e PVP=$MINECRAFT_PVP \
    -e OPS=$MINECRAFT_OPS \
    -e VERSION=LATEST \
    -e ENABLE_RCON=false \
    -e EULA=true \
    -e ENABLE_COMMAND_BLOCK=true \
    -e ONLINE_MODE=true \
    -e ANNOUNCE_PLAYER_ACHIEVMENTS=false \
    -v $MINECRAFT_CONTAINER_NAME-data:/data \
    itzg/minecraft-server
