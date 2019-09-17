#!/bin/bash

#Install mongodb

echo ""
echo ""
echo "**************************************************************"
echo "*************         Setting up MongoDB         *************"
echo "**************************************************************"
echo ""
echo ""


if [ ! -f /opt/mongo_installed.done ]
then

	#HOWTO: http://docs.mongodb.org/manual/tutorial/install-mongodb-on-linux/
	echo " - get key"
	#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
	#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
	wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | sudo apt-key add -
	#wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

	echo " - add repo"
	echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
	#echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
	
	echo " - update package lists"
	apt-get update

	#Download and install 64 bit distro
	echo " - install package(s)"
	#apt-get install -y mongodb-org=3.4.X mongodb-org-server=3.4.X mongodb-org-shell=3.4.X mongodb-org-mongos=3.4.X mongodb-org-tools=3.4.X
	apt-get install -y mongodb-org=3.6.5
	#apt-get install -y mongodb-org

	#Tidy up
	apt-get clean

	#----
    echo " - set up mongo permissions"
    usermod -a -G mongodb oustudent
    #---

		#If not the Docker build, set up the services
		if [[ -z "${DOCKERBUILD}" ]]; then
    	echo " - update mongo conf files"
    	THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    	cp $THISDIR/etc/mongodb.conf /etc/mongodb.conf
    	cp $THISDIR/services/mongodb.service /lib/systemd/system/mongodb.service
		fi

    echo -n "...done install"

    touch /opt/mongo_installed.done
else
	echo "...already installed"
fi

#If not the Docker build, set up the services
if [[ -z "${DOCKERBUILD}" ]]; then
	systemctl enable mongodb
	systemctl daemon-reload
	systemctl restart mongodb
fi


#chown mongodb ${THISDIR}/sharded/mongo_cluster.sh
#chown :mongodb ${THISDIR}/sharded/mongo_cluster.sh


#Additionally bring in command line tools to help with data grab
apt-get install -y curl zip unzip bzip2 wget

echo ""
echo ""
echo "**************************************************************"
echo "*************      DONE: setting up MongoDB      *************"
echo "**************************************************************"
echo ""
echo ""
