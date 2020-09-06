#!/bin/bash
# install packages from apt

HM="$(cd .. && pwd)"
LOG_DEST="$HM/logs/apt.txt"

# print pretty
pprint() {
  echo -e "${1} " | figlet | lolcat
}

#update and upgrade
update() {
  sudo apt-get update && sudo apt-get upgrade -y > $LOG_DEST
}

# Install package manager
package_managers() {
  pprint "Package Managers"
  sudo apt-get install synaptic gdebi snapd -y # > $LOG_DEST
}

# user settings
settings() {
  pprint "User Settings"
  sudo apt-get install gnome-tweak-tool autoconf -y > $LOG_DEST
  sudo apt-get install automake wget sassc pkg-config optipng -y > $LOG_DEST
  sudo apt-get install numix-icon-theme python3-pip -y > $LOG_DEST
}

# network
network() {
  pprint "network";
  sudo apt-get install net-tools nmap apt-transport-https hping3 -y > $LOG_DEST

  # internet
  pprint "Internet"
  # download google chrome
  wget -qO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome*.deb -y > $LOG_DEST
  #-----
  sudo apt-get install chrome-gnome-shell links bittorrent git -y > $LOG_DEST
}

# media
media(){
  pprint "Media"; sleep 1;
  sudo apt-get install vlc -y > $LOG_DEST
  # spotify
  # curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
  # echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
}

# programming
prgms() {
  pprint "Programming"; sleep 1;
  sudo apt-get install gcc g++ sqlitebrowser mariadb-client mariadb-common openjdk-11-jdk -y > $LOG_DEST
}

# system/utilities
utilities() {
  pprint "Utilities"
  sudo apt-get install afflib-tools netdiscover wireshark openssl -y
  sudo apt-get install htop gtkhash ghex -y > $LOG_DEST

}

# office
office() {
  pprint "Office"
  sudo apt-get install texmaker cherrytree -y > $LOG_DEST
  pprint "ATOM"
  wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
  sudo apt-get update > $LOG_DEST
  sudo apt-get install atom -y > $LOG_DEST

  # sublime
  pprint "SUBLIME"
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get update -y > $LOG_DEST
  sudo apt-get install sublime-text -y > $LOG_DEST
}

install_all() {
  update;
  package_managers;
  settings;
  network;
  media;
  prgms;
  utilities;
  office;
}

# make ask function
ask_user() {
  read -p "Do you want to install ${1}? (Y/n) : " answer
  while true
  do
    case $answer in
      [yY]* ) ${1};
              break;;

      [nN]* ) exit;;

      * )     echo "Invalid input"
              echo -e "Enter (y/n)"
     esac
   done
}

install_packages() {
  # ask yes or now for each "genre" of packages
  ask_user update;
  ask_user package_managers;
  ask_user settings;
  ask_user network;
  ask_user media;
  ask_user prgms;
  ask_user utilities;
  ask_user office;
}

install_packages;
