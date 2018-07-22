#!/bin/bash

############  DOCKER #############
# Setting up Docker Repository

echo "Configuring Docker Repository..."
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

echo "Updating yum repositories..."
sudo yum -y update

echo "Installing docker..."
sudo yum -y install docker-ce

echo "htop, vim, git, fail2ban"
sudo yum -y install htop, vim, git, fail2ban

echo "Starting docker..."
sudo systemctl start docker

echo "Starting fail2ban..."
sudo systemctl start fail2ban


