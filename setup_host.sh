#!/bin/bash
set -ex
echo "updating packages"
apt update -y

echo "Installing git"
apt install git -y

echo "Installing Docker"
# Add Docker's official GPG key:
apt install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu jammy stable" \
  > /etc/apt/sources.list.d/docker.list

apt update -y
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "start docker"
systemctl start docker 
systemctl enable docker

if docker --version && git --version
then
   echo "git and docker installed successfully"
   systemctl status docker 
else
   echo "Not install"
fi
