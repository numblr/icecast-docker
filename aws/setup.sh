#!/bin/bash

## Run with source
## Amazon Linux on arm64 architecture, t4g.micro instace with 8GB disk

sudo yum -y update
sudo yum -y install docker git vim-enhanced htop less
echo "Installed libs"

mkdir -p log web admin config
chmod -R 777 config log web admin
echo "Setup directories"

sudo usermod -a -G docker ec2-user
id ec2-user
/usr/bin/newgrp docker <<EONG
echo "Setup permissions"

sudo systemctl enable docker.service
sudo systemctl start docker.service
echo "Started docker"


echo "==== LOGOUT AND RECONNECT! ====="
