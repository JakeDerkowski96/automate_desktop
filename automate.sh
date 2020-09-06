#!/bin/bash
# automate fresh installation, to include:
# 1. make terminal pretty, make aliases
# 2. install packages and applications && update
# 3. install snaps
# experiment with bash automation

DIR=$(pwd)
FUNC=".functions.sh"

source $FUNC

# automate installaton
auto_install(){
  read -p "Automate installation? [Y/n]?  : " answer
  while true
  do
    case $answer in
      [Yy]* ) echo -e "ok, i got ya"; echo; sleep 0.5;

      echo -e "Details found in the 'logs' folder";
      check_dir logs;
      echo "Installing prerequistes"; sleep 0.5;
      required > "logs/prereqs";
      check_dir scripts;

      # note
      echo "automate other deb packages coming soon.."; sleep 1;

      echo -e "beginning..."; sleep 0.5;

      # dispaly pretty terminal
      show_host_ip;

      # check_dir "deb";
      pprint Terminal;
      term_check;

      get_ans "packages" $PKGS;
      get_ans "snaps" $SNAPS;

      break;;

      [Nn]* ) echo -e "why run this then?"
              exit;;

      * ) echo "Invalid input";
          break;;
    esac
  done
}

auto_install;
