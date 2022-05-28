#!/bin/bash

source scripts
sudo apt-get update --yes > log
sudo apt-get upgrade --yes > log
sudo apt-get install $deps --yes > log

cat /etc/locale.gen | grep -v '#' | grep "uk_UA.UTF-8 UTF-8" || echo "uk_UA.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen"

sudo locale-gen

