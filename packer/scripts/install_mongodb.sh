#!/bin/bash

apt-get update
sleep 60
apt-get install mongodb -y
systemctl start mongodb
systemctl enable mongodb
