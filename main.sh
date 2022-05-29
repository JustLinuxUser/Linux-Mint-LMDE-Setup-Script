#!/bin/bash

source scripts/deps.sh
export SUDO_ASKPASS=scripts/askpass
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

rm log

run () {
   sudo -A -v
   echo -e "${GREEN} RUNNING: ${NC} ${2}" | tee -a log
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
run "sudo apt-get upgrade --yes" "Upgrade install packages"
run "sudo apt-get install $deps --yes" "Installing packages \(may take a long time\)"

if $(cat /etc/locale.gen | grep -E "^uk_UA.UTF-8 UTF-8"); then
	run 'echo "uk_UA.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen"' 'Adding ukrainian locale'
	run 'sudo locale-gen' 'regenerating locale'
run "cp configs/home/caracole/* ~/" "Change language"

## DNS!!!
