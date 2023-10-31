#!/bin/bash

apt-get update
sleep 60
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
sudo apt-get install -y -q
apt-get install -y ruby-full ruby-bundler build-essential
sleep 60
