#!/bin/bash

apt-get update && \
apt-get install -y git && \
cat << EOF >> /lib/systemd/system/reddit.service &&
[Unit]
Description=RedditApp
After=syslog.target
After=network.target
After=mongodb.service
Requires=mongodb.service

[Service]
Type=forking
PIDFile=/var/run/redditapp.pid
WorkingDirectory=/opt/reddit

#TimeoutSec=300

ExecStart=/usr/local/bin/puma -d --dir /opt/reddit --pidfile /var/run/redditapp.pid

EOF
cd /opt && \
git clone -b monolith https://github.com/express42/reddit.git && \
cd /opt/reddit && bundle install && \
systemctl start reddit && \
systemctl enable reddit && \
sed -i -e '$i \systemctl start reddit \n' /etc/rc.local
