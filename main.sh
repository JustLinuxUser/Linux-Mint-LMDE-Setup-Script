#!/bin/bash

export SUDO_ASKPASS=scripts/askpass #For sudo -A

req=$(cat INSTALL | grep -E '^[^#][a-z-]*') #delete '#' and empty lines

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

rm -f log # remove logfile if exists

run () {
   sudo -A -v &> /dev/null
   echo -e "${YELLOW} RUNNING: ${NC} ${2}" | tee -a log
   $1 &>> log
   if [ $? -eq 0 ]; then
   	echo -e "${GREEN} SUCCESS: ${NC} ${2}"
   else
   	echo -e "${RED}FAIL: ${NC} ${2}"
	echo -e "${RED}COMMAND FAILED: ${NC} ${1}"
	echo "Please check the log"
	echo "Exiting ..."
	exit -1
   fi
}

run "sudo apt-get update --yes" \
"Update package database"

run "sudo apt-get upgrade --yes" \
"Upgrade installed packages (may take a long time)"

run "sudo apt-get install $req --yes" \
"Install packages (may take a long time)"

# Check if Ukrainian locale is already enabled
if [ -z "$(cat /etc/locale.gen | grep -E "^uk_UA.UTF-8 UTF-8")" ]; then
	run 'echo "uk_UA.UTF-8 UTF-8" | \
		sudo tee -a /etc/locale.gen"' \
		'Adding ukrainian locale'
fi

run 'sudo locale-gen' 'regenerating locale'
run "cp configs/home/user/.*[!.] $HOME" "Changing system language"

run 'dconf write /org/gnome/libgnomekbd/keyboard/layouts "[\'es\', \'us\', \'ua\']"' \
"Set keyboard layout"

run 'dconf write /org/gnome/libgnomekbd/keyboard/options "[\'grp\tgrp:win_space_toggle\',\
\'terminate\tterminate:ctrl_alt_bksp\', \'grp\tgrp:lalt_lshift_toggle\']"' \
'Set ALT+SHIFT as a ketboard shorkcut'


user_dirs=$(cat .config/user-dirs.dirs | \
tail -n8| \
awk -F/ '{print $2}' | \
awk -F\" '{print $1}')

run "LC_ALL=uk_UA.UTF-8 xdg-user-dirs-update --force" "Change home folder names to ukrainian"

run "rm -rf $user_dirs" "Remove previous dirs"


run "echo 'nameserver 8.8.8.8'| sudo tee /etc/resolv.conf" \
"Setting up DNS(1/2)"
run "chmod 444 /etc/resolv.conf"\
"Setting up DNS(2/2)"
