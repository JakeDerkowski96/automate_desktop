#!/bin/bash
# install snaps
# ===========================================
HOME_DIR="$(cd .. && pwd)"
SNAP_LOG="${HOME_DIR}/logs/snaps.txt"
# ===========================================

pprint "SNAPS"
touch SNAP_LOG


echo "more info @ ${HOME_DIR}/logs/snap.txt"

install_snaps(){
  # sudo snap install bitwarden
  sudo snap install code --classic
  # sudo snap install discord
  # sudo snap install eclipse --classic
  sudo snap install john-the-ripper
  # sudo snap install postgresql10
  # sudo snap install powershell --classic
  # sudo snap install simplenote
}

install_snaps > $SNAP_LOG

figlet "Oh Snap"; sleep 2;
echo -e "Done.";
