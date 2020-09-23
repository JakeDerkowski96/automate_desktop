#!/bin/bash
# install and configure fail2ban
# protection from DDoS and

FUNC=".script_functions.sh"
HIDE="/dev/null"
source $FUNC

F2BLOG="$HOMEDIR/logs/fail2ban.txt"


install(){
  update_grade;
  # create log file
  touch $F2BLOG
  sudo apt-get install -y fail2ban >> $F2BLOG
}

enable_F2B(){
  sudo systemctl start fail2ban
  sudo systemctl enable fail2ban
}

JAIL="[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3"


make_jail(){
  sudo touch /etc/fail2ban/jail.local
  echo $JAIL > /etc/fail2ban/jail.local
}

install;
ask_user enable_F2B;
