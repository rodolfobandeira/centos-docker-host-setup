#!/bin/bash

############  DOCKER #############
# Setting up Docker Repository

echo "Configuring Docker Repository..."
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

echo "Updating yum repositories..."
yum -y update

echo "Installing docker..."
yum -y install docker-ce

echo "htop, vim, git, fail2ban"
yum -y install htop, vim, git, fail2ban

echo "Starting docker..."
systemctl start docker

echo "Starting fail2ban..."
systemctl start fail2ban

echo "Setting up SSH keys"
pkill ssh-agent

# Only creates a new SSH_KEY if it doesn't exist
SSH_PRIVATE_KEY=~/.ssh/id_rsa
if [ ! -f $SSH_PRIVATE_KEY ]; then
  yes ~/.ssh/id_rsa |ssh-keygen -q -t rsa -b 4096 -C "CentOS" -N '' >/dev/null
fi

eval "$(ssh-agent -s)"
chmod 400 ~/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa

echo "Your ssh public key: \n\n"
cat ~/.ssh/id_rsa.pub
echo "\n\n"

echo "Setting up docker-compose"
yum install -y epel-release
yum install -y python-pip
yum upgrade python*
pip install --upgrade pip
pip install docker-compose

SWAP_FILE=/swapfile2GB
if [ ! -f $SWAP_FILE ]; then
  echo "Creating an extra 2GB swapfile"
  dd if=/dev/zero of=/swapfile2GB bs=1M count=2048
  mkswap /swapfile2GB
  chmod 600
  swapon /swapfile2GB
  echo 'echo "/swapfile  none  swap  defaults  0  0" >> /etc/fstab' | sudo sh
  free -m
fi

echo "\n\nDone\n\n"
