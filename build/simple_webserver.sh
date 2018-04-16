#!/usr/bin/env bash

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Install nginx
#apache2-utils contains htpassword command to configure password used to restrict access to target ports
apt-get update && apt-get install -y nginx

config="""
server {
  listen 80;
  location / {
    root /var/www/html ;
    index index.html;
  }
}
"""

echo "$config" > /etc/nginx/sites-available/default

mkdir -p /var/www/html
cp -a $THISDIR/www/. /var/www/html

# Refresh service config
systemctl daemon-reload

service nginx reload


