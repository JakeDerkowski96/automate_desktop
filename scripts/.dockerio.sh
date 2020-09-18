#!/bin/bash
# install docker.io

# update apt
sudo apt-get update

# install prereqs
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common


# add Docker's GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# verify key has correct fingeer print
sudo apt-key fingerprint 0EBFCD88

# add repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# update again
sudo apt-get update

# install packages
sudo apt-get install docker-ce docker-ce-cli containerd.io
