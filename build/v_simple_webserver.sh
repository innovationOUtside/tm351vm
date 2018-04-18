#!/usr/bin/env bash

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


mkdir -p /var/www/html
cp -a $THISDIR/www/. /var/www/html
cp $THISDIR/services/pyhttpserver.service /lib/systemd/system/pyhttpserver.service

# Enable autostart
systemctl enable pyhttpserver.service

# Refresh service config
systemctl daemon-reload
	
systemctl restart  pyhttpserver


