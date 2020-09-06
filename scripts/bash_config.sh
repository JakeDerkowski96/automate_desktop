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
  if [ -f "${1}" ]; then
    cp $1 "${1}.bak"
  fi
}

# cp my aliases into home
make_aliases(){
  TARGET=$ALIAS_LOC;
  BackUpBash $TARGET;
  cp $ALIAS_USR $ALIAS_LOC;
}

# BACKUP AND CP NEW BASHRC
make_rc() {
  TARGET=$BASH_LOC;
  BackUpBash $TARGET;
  cp $BASH_USR $BASH_LOC;
}

testing_bash() {
  cat ls -a $HOME
  cat $ALIAS_LOC;
  cat $BASH_LOC;
}

make_aliases $ALIAS_LOC;
make_rc $BASH_LOC
testing_bash
