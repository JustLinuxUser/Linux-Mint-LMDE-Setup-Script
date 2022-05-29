#!/bin/bash

source scripts/deps.sh
export SUDO_ASKPASS=scripts/askpass
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

rm log

run () {
   sudo -A -v
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

run "sudo apt-get update --yes" "Update package database"
run "sudo apt-get upgrade --yes" "Upgrade installed packages \(may take a long time\)"
run "sudo apt-get install $deps --yes" "Install packages \(may take a long time\)"

if $(cat /etc/locale.gen | grep -E "^uk_UA.UTF-8 UTF-8"); then
	run 'echo "uk_UA.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen"' 'Adding ukrainian locale'
	run 'sudo locale-gen' 'regenerating locale'
fi
run "cp configs/home/caracola/* ~/" "Change language"

## DNS!!!
