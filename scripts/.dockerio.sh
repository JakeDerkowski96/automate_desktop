#!/bin/bash
# install docker.io

# this can be transfered to the other scripts 
# to only make log files if installation desired

# install funcion
HOMEDIR="$(cd .. && pwd)"
LOGDIR="$HOMEDIR/logs"
# touch "$LOGDIR/docker.txt"


docker_install(){
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

  sleep 1;

  # verify key has correct fingeer print
  sudo apt-key fingerprint 0EBFCD88

  # add repository
  sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

  # update again
  echo "Installing docker.io" | figlet | lolcat
  sudo apt-get update > /dev/null;


  # install packages
  sudo apt-get install docker-ce docker-ce-cli containerd.io -y
}

echo -e "This installation is specifically for Ubuntu"; sleep 1;
echo -e "If running a different distribution, this installation will not work"

read -p "Would you like to continue? (Y/n) " cont
while true; do
  case $cont in
    [yY]* ) docker_install
            break;;

    [nN]* ) echo -e "visit 'https://docs.docker.com/engine/install/' for information";
            exit;;

    * )     echo -e "Invalid input";
  esac
done
