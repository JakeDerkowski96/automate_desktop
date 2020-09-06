#!/bin/bash
# ===========================================
HOME_DIR="$(cd .. && pwd)"
CONTENT_DIR="$HOME_DIR/.content"
# ===========================================
NEW_BASH="$HOME_DIR/my_bashrc"
NEW_ALIASES="$HOME_DIR/my_aliases"
# ===========================================
ALIAS_LOC="${HOME}/.bash_aliases"
BASH_LOC="${HOME}/.bashrc"
# ===========================================
# back up bash aliases if exist
BackUpBash(){
  if [ -f "${1}" ]; then
    cp "${1}" "${1}.bak"
  else
    touch "${1}"
  fi
}

echo "Backing up exisiting/making new files.."; sleep 1;

BackUpBash $ALIAS_LOC;
BackUpBash $BASH_LOC;

echo -e "Moving my files to yo spot"; sleep 1;
cp $NEW_ALIASES $ALIAS_LOC
cp $NEW_BASH $BASH_LOC

echo -e "testing new terminal settings"
source "$HOME/.bashrc"; sleep 2;

echo "Terminal Complete"
