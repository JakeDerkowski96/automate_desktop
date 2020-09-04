#!/bin/bash
# install snaps

HOME_DIR="$(cd .. && pwd)"
source functions.sh
SNAP_LOG="${LOG_DEST}/snaps.txt"

prereqs() {
  sudo apt-get update
  sudo apt-get install snapd -y
}

pprint "SNAPS"

prereqs > "logs/snap.tx"

echo "more info @ ${pwd}/logs/snap.txt"

install_snaps(){
  sudo snap install bitwarden
  sudo snap install code --classic
  sudo snap install discord
  sudo snap install eclipse --classic
  sudo snap install john-the-ripper
  sudo snap install postgresql10
  sudo snap install powershell --classic
  sudo snap install simplenote
}

install_snaps # > $SNAP_LOG

figlet "Oh Snap"
sleep 2;
