#!/bin/bash
# make the main program pretty
# have function declarations/definitions here


SYSUSR=$USER # MAIN USER
INSTALL_HOME=$(pwd)
SCRIPTS="$INSTALL_HOME/scripts"
PKGS="${SCRIPTS}/packages.sh"
SNAPS="${SCRIPTS}/snaps.sh"
# DEBS="${SCRIPTS}/debs.sh"

CONTENT="$INSTALL_HOME/.content"

# download prereqs to make terminal pretty + progress bar
required() {
  echo "Downloading prerequistes..."
  sudo apt-get update
  sudo apt-get install lolcat figlet snapd pv libncurses5-dev progress -y
}

# print pretty
pprint() {
  echo -e "${1} " | figlet | lolcat
}

# put into separate directory and `chmod` recursively
execution() {
  find $SCRIPTS -type f -iname "*.sh" -exec chmod +x {} \;
}

# RIGHT BEFORE INSTALLATION
show_host_ip() {
  echo "Begin configuration for:"; sleep 1;
  pprint $USER; sleep 2;

  echo -e "on"; sleep 0.5;
  pprint "$(hostname -s)"; sleep 1;

  echo -e "@"; sleep 0.5;
  pprint "$(hostname -I)"; sleep 1;
}


# check if does exists
check_dir(){
	if [ ! -d "${1}" ]; then
    if [ $1 == "logs" ]; then
      mkdir "${1}";
    else
      echo -e "${1} is essential for installation, will not complete successfully."
      echo -e "If you were smart you control-c the hell outta here"; sleep 2;
      echo -e "but, nevertheless..."
    fi
  # optional check
	else
		echo "found: ${1} ";
	fi
}

# check user wants my terminal config
term_check() {
  read -p "Want my terminal settings (Y/n)? : " answer
  while true; do
    case $answer in
      [Yy]* ) sudo bash "$SCRIPTS/bash.sh";
              break;;

      [Nn]* ) exit;;

      * )     echo "Invalid input";
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


# get answer $1=name of package
# $2 script location
get_ans() {
  read -p "Do you wish to install ${1}? (Y/n) : " ans
  while true; do
    case $ans in
      [yY]* ) start_install "${1}";
              bash "${2}" > "logs/${1}.txt";
              finish_install;
              break;;

      [nN]* ) echo -e "thanks for using!";
              exit;;

      * )     echo -e "Enter 'y' for yes, 'n' for no."
    esac
  done
}

execution;
check_dir logs;
