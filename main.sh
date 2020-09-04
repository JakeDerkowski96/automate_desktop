#!/bin/bash
# automate fresh installation, to include:
# 1. make terminal pretty, make aliases
# 2. install packages and applications && update
# 3. install snaps
# experiment with bash automation

FUNC="functions.sh"

source $FUNC

# automate installaton
auto_install(){
  read -p "Automate installation? [Y/n]?  : " answer
  while true
  do
    case $answer in
      [Yy]* ) echo -e "ok, i got ya"; echo; sleep 0.5;
      # check_uid;
      required > /dev/null;
      check_directory logs;
      break;;

      [Nn]* ) echo -e "why run this then?"
      exit;;

      * ) echo "Invalid input"; break;;
    esac
  done
}

# dispaly pretty terminal
show_host_ip;

#check if want to use
auto_install;

# terminal
pprint "Terminal";
sleep 1;
term_check;
source $HOME/.bashrc
pprint "DONE"; sleep 3;

# install packages
install_everything;
