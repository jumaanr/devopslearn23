#!/bin/bash

# Configuring the hostname
hostnamectl set-hostname devops-server

#Configure Network
nmcli con show
nmcli device show
nmcli connection add con-name networkadapter1 ifname networkadapter1 type ethernet ipv4.addresses 192.168.1.120 gw4 192.168.1.1
nmcli connection modify networkadapter1 ipv4.dns 192.168.1.1
nmcli connection modify networkadapter1 ipv4.method manual
nmcli connection modify networkadapter1 connection.autoconnect true

# down the current interface and up the new interface
nmcli con down ens33
nmcli dev disconnect ens33
nmcli con up networkadapter1

nmcli n on
nmcli n off

#Reboot computer
systemctl reboot

#Git Installation
sudo yum update
sudo yum install git
git --version

#Install Docker : https://docs.docker.com/engine/install/centos/
sudo yum update
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo docker run hello-world
#Add the user for following group to be able to use docker without sudo
sudo usermod -aG docker your_username
#Added the user to sudo users , password is pass@123
usermod -aG wheel devops