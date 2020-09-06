#!/bin/bash
# ===========================================
HOME_DIR="$(cd .. && pwd)"
CONTENT_DIR="$HOME_DIR/.content"
# ===========================================
NEW_BASH="$CONTENT_DIR/my_bashrc"
NEW_ALIASES="$CONTENT_DIR/my_aliases"
# ===========================================
ALIAS_LOC="${HOME}/.bash_aliases"
BASH_LOC="${HOME}/.bashrc"
# ===========================================
# back up bash aliases if exist
BackUpBash(){
  if [ -f "$HOME/${1}" ]; then
    cp $1 "$HOME/{1}.bak"
  else
    touch "$HOME/${1}"
  fi
}

# $1 is source
# $2 is destination
my_term() {
  BackUpBash "${2}";
  cp $1 $2
}

testing_bash() {
  cat ls -a $HOME
  cat $ALIAS_LOC;
  cat $BASH_LOC;
}

term_main(){
  my_term $NEW_ALIASES $ALIAS_LOC;
  my_term $NEW_BASH $BASH_LOC;
}

term_main;
source "$HOME/.bashrc"
sleep 1;


#
# make_aliases $ALIAS_LOC;
# make_rc $BASH_LOC
# # testing_bash
