#!/bin/bash
# automate fresh installation, to include:
# 1. make terminal pretty, make aliases
# 2. install packages and applications && update
# 3. install snaps
# experiment with bash automation

SYSUSR=$USER # MAIN USER
CWD=$(pwd)
SCRIPTS="${CWD}/scripts"
PKGS="${SCRIPTS}/packages.sh"
SNAPS="${SCRIPTS}/snaps.sh"
TERM="${SCRIPTS}/bash.sh"
# DEBS="${SCRIPTS}/debs.sh"

FUNC=".functions.sh"

source $FUNC

# automate installaton
read -p "Automate installation? [Y/n]?  : " answer
while true
do
  case $answer in
    [Yy]* ) echo -e "ok, i got ya"; echo; sleep 0.5;

    echo -e "Details found in the 'logs' folder";
    # check_dir logs;
    echo "Installing prerequistes"; sleep 0.5;
    required > "logs/prereqs.txt";
    check_dir scripts;

    # note
    echo "automate other deb packages coming soon.."; sleep 1;

    echo -e "beginning..."; sleep 0.5;

    # dispaly pretty terminal
    show_host_ip;

    # pprint Terminal;
    # term_check;
    get_ans "Terminal" $TERMIN;
    get_ans "Packages" $PKGS;
    get_ans "Snaps" $SNAPS;

    # check_dir "deb";
    
    break;;

    [Nn]* ) echo -e "why run this then?"
            exit;;

    * ) echo "Invalid input";
        break;;
  esac
done
