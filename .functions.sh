#!/bin/bash
# make the main program pretty
# have function declarations/definitions here


SYSUSR=$USER # MAIN USER
INSTALL_HOME=$(pwd)
SCRIPTS="$INSTALL_HOME/scripts"
CONTENT="$INSTALL_HOME/.content"


# make_exec() {
#   chmod +x .BASHCONFIG.sh
#   chmod +x .package.sh
#   chmod +x .snap.sh
#   chmod +x .deb_install.sh
# }

# download prereqs to make terminal pretty + progress bar
required() {
  echo "Downloading prerequistes..."
  sudo apt-get update
  sudo apt-get install lolcat figlet snapd pv libncurses5-dev progress -y
}

# put into separate directory and `chmod` recursively
execution() {
  find $1 -type f -iname "*.sh" -exec chmod +x {} \;
}

# RIGHT BEFORE INSTALLATION
show_host_ip() {
  echo "Begin configuration for:"; pprint $USER;
  sleep 2

  echo -e "on"
  pprint "$(hostname -s)"; sleep 1;

  echo -e "@"
  pprint "$(hostname -I)"; sleep 1;
}

# print pretty
pprint() {
  echo -e "${1} " | figlet | lolcat
}

# check if does exists
check_dir(){
	if [ ! -d "${1}" ]; then
    if [ $1 == "logs" ]; then
      mkdir "${1}";
    else
      echo "${1} is essential for installation."
    fi
  # optional check
	else
		echo "${1} exists";
	fi
}

# check user wants my terminal config
term_check() {
  read -p "Do you want my terminal [Y/n]? : " answer
  while true
  do
    case $answer in
      [Yy]* ) pprint terminal;
              sudo bash "$SCRIPTS/bash.sh";
              pwd;
              break;;

      [Nn]* ) exit;;

      * ) echo "Invalid input"; break;;
    esac
  done
}


# DISPLAY WHAT IS INSTALLING
begin_install() {
  echo -e "preparing to install";  sleep 0.5; pprint ${1};
}

# DISPLAY COMPLETE INSTALL
complete_install() {
  echo -e "DONE"; sleep 0.5;
}

install_everything(){
  read -p "Would you like to continue? [Y/n] : " answer
  while true
  do
    case $answer in
     [yY]* ) read -p "Would you like to install all packages? [Y/n] : " answer
  	 				 while true
  					 do
  						 case $answer in
  							 [yY]* ) begin_install packages;
                         bash "$SCRIPTS/packages.sh";
                         complete_install;

  							 				 read -p "Install Snaps? [Y/n] : " answer
  											 while true
  											 do
  												 case $answer in
  													 [yY]* ) begin_install snaps;
                                     bash "$SCRIPTS/snap.sh";
                                     complete_install;

  													 [nN]* ) "Thanks for using"; exit;;

  													 * )      echo "Invalid input."; break;;
  												 esac
  											 done

  							 [nN]* ) echo -e "You're missing out!" exit;;

  							 * )     echo "Invalid input."; break ;;
  						 esac
  					 done
             exit;;

     [nN]* ) exit;;

     * )     echo "Invalid input."; break ;;
    esac
  done
}

required;
execution;
