#!/bin/bash
# make the main program pretty
# have function declarations/definitions here


SYSUSR=$USER # MAIN USER
INSTALL_HOME=$(pwd)
SCRIPTS="$INSTALL_HOME/scripts"
PKGS="${SCRIPTS}/packages.sh"
SNAPS="${SCRIPTS}/snaps.sh"
TERMIN="$SCRIPTS/bash.sh"
# DEBS="${SCRIPTS}/debs.sh"

CONTENT="$INSTALL_HOME/.content"

# download prereqs to make terminal pretty + progress bar
required() {
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
      [Yy]* ) bash "$SCRIPTS/bash.sh";
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

# $1 = what is being asked to install
# $2 = script
get_ans() {
  SCRIPT="${2}"
  read -p "Do you want to install ${1}? : " ans
  while true; do
    case $ans in
      [yY]* ) start_install ${1}
              bash $SCRIPT
              finish_install;
              break;;
      [nN]* ) exit;;

      * ) echo -e "Invalid input"
    esac
  done
}



execution;
echo -e "Installing prerequistes..."; sleep 0.5;

check_dir logs;
required > "logs/prereqs.txt";
check_dir scripts;

touch logs/packages.txt
touch logs/snaps.txt
touch logs/prereqs.txt
# touch logs/debs.txt
