#!/bin/bash

until apt-get update 2>&1; do
  sleep 1
done
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
sudo apt-get install -y -q
until apt-get install -y ruby-full ruby-bundler build-essential 2>&1; do
  sleep 1
done
