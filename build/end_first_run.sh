#!/usr/bin/env bash

if [ ! -f /opt/firstrun.done ]; then
	touch /opt/firstrun.done
    echo "Restart from first/build run..."
    echo ""
    echo ""
    echo "*********************************************************"
    echo "*************  THE MACHINE HAS BEEN HALTED  *************"
    echo "*************       RUN: vagrant reload     *************"
    echo "*********************************************************"
    echo ""
    echo ""
    echo ""
    
    shutdown -r now
fi