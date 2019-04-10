#!/usr/bin/env bash

#Install docker on ubuntu

VERSION_STRING=17.03


# Set up Docker repositories and install from them, for ease of installation and upgrade tasks. 
# This is the recommended approach.

#Steps:-
# 1. Update the apt package index:
sudo su
apt-get update -y
# 2. Install dependency packages to allow apt to use a repository over HTTPS:
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
# 3. Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# 4. Verify fingerprint last 4 chars -> 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
apt-key fingerprint 0EBFCD88

# 5. Set repositiry type [stable|nightly|test]
add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
# 6. Update the apt package index to reflect repo changes
apt-get update
# 7. Install latest verion
# sudo apt-get install docker-ce docker-ce-cli containerd.io
# 8. Install specific verion 
# List the versions available in the repo
#apt-cache madison docker-ce
#sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep $VERSION_STRING | head -1 | awk '{print $3}') containerd.io


# 9. run docker commands as vagrant user (sudo not required)
usermod -aG docker vagrant
# ip of this box
apt-get install -y python-minimal
IP_ADDR=`ifconfig enp0s8 | grep Mask | awk '{print $2}'| cut -f2 -d:`
echo $IP_ADDR

    
