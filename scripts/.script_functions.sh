#!/bin/bash
# functions for global use

# misc / other log file
HOMEDIR="$(cd .. && pwd)"
LOGZ="$HOMEDIR/logs/other.txt"

log_separater() { printf "\n===========================================================\n" >> $LOGZ; }

# print pretty
pprint() {
  echo -e "${1} " | figlet | lolcat
}

update_grade(){
  sudo apt-get update > /dev/null;
  sudo apt-get upgrade -y > /dev/null
}

# ask for permission
ask_user() {
  read -p "Do you want to install ${1}? (Y/n) : " answer
  while true; do
    case $answer in
      [yY]* ) ${1};
              break;;

      [nN]* ) exit;;

      * )     echo "Invalid input"
              echo -e "Enter (y/n)"
     esac
   done
}

# DISPLAY WHAT IS INSTALLING
start_install() {
  echo -e "preparing to install: ";
  sleep 0.5; pprint ${1};
}

# DISPLAY COMPLETE INSTALL
finish_install() {
  echo -e "DONE"; sleep 0.5;
  echo "Details found in log directory "
}
