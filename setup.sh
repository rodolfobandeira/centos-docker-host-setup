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

echo "Setting up SSH keys"
yes ~/.ssh/id_rsa |ssh-keygen -q -t rsa -b 4096 -C "CentOS" -N '' >/dev/null
eval "$(ssh-agent -s)"
chmod 400 ~/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa

echo "Your ssh public key: \n\n"
cat ~/.ssh/id_rsa.pub
echo "\n\n"
