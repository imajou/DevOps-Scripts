#!/bin/sh

sudo fallocate -l 1G /swap
sudo chmod 600 /swap
sudo mkswap /swap
sudo swapon /swap
echo '/swap swap swap defaults 0 0' | sudo tee -a /etc/fstab
