#!/bin/bash
# install github cli

FUNC=".script_functions.sh"
HIDE="/dev/null"
source $FUNC


github_cli(){
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
  sudo apt-add-repository https://cli.github.com/packages
  sudo apt update >> $HIDE
  sudo apt install gh -y
}

log_separater
ask_user github_cli;
start_install gh cli;
log_separater
