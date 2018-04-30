#!/bin/bash

#Crib: https://premaseem.wordpress.com/2016/02/14/mongodb-script-to-run-sharding-with-replica-set-on-local-machine/

#DEBUG TOOLS
#systemctl list-units | grep mongo
#sudo lsof -iTCP -sTCP:LISTEN | grep mongo
#journalctl -u mongodb.service

echo "Setting up mongo cluster..."

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p /vagrant/logs

MONGOD_PORT=27017



if [ ! -f /opt/mongo_shard_perms.done ]
then
    echo " - set up mongo shard commands"

    cp $THISDIR/etc/mongo-shards-down /etc/mongo-shards-down
    chown mongodb:mongodb /etc/mongo-shards-down
    chmod a+x /etc/mongo-shards-down

    cp $THISDIR/etc/mongo-shards-up /etc/mongo-shards-up
    chown mongodb:mongodb /etc/mongo-shards-down
    chmod a+x /etc/mongo-shards-up

    echo " - set up mongo permissions"
    #Add oustudent user to mongodb group
    usermod -a -G mongodb oustudent
    #Grant permissions on certain commands to mongodb group
    echo '''
    %mongodb    ALL=NOPASSWD:   /usr/bin/killall mongod
    %mongodb    ALL=NOPASSWD:   /usr/bin/killall mongos
    %mongodb    ALL=NOPASSWD:   /bin/systemctl restart mongodb
    %mongodb    ALL=NOPASSWD:   /etc/mongo-shards-down
    %mongodb    ALL=NOPASSWD:   /etc/mongo-shards-up
    '''  >> /etc/sudoers
    
    touch /opt/mongo_shard_perms.done
fi
#--------------



##
if [ ! -f /opt/mongo_shard_restore.done ]; then

    echo "killing mongod and mongos"
    killall mongod
    killall mongos

    sleep 3
    if [[ -z "${DOCKERBUILD}" ]]; then
        systemctl restart mongodb
    fi

    sleep 5
    
    #echo "removing data files"
    #sudo rm -rf /data/config
    #sudo rm -rf /data/shard*

    rm -rf /data/config
    rm -rf /data/shard*

    #Create shard folders
    mkdir -p /data/shard0/rs0
    chmod -R a+rwx /data/shard0/rs0

    mkdir -p /data/shard1/rs0
    chmod -R a+rwx /data/shard1/rs0

    mkdir -p /data/shard2/rs0
    chmod -R a+rwx /data/shard2/rs0

    #Create configsvr folder
    mkdir -p /data/config/config-a
    chmod -R a+rwx  /data/config/config-a
    
    #Fire up the servers
    /etc/mongo-shards-up

    #add the shards
    echo "Connecting to mongos and enabling sharding"
    # add shards and enable sharding on the test db
    mongo < ${THISDIR}/createshards.js


    #--------- SEED THE DATABASE WITH SOME DATA

    ##Copy across and unpack the data files into the VM

    #Example of creating tar.bz2 file: 
    # tar -cvjSf filename.tar.bz2 dirname

    echo "Copy some data across (if required)..."
    if [ ! -f /root/accidents-0912.tar.bz2 ]; then
        cp $THISDIR/data/accidents-0912.tar.bz2 /root/accidents-0912.tar.bz2
    fi
    echo "...data copied"

    echo "Unpack some data (if required)..."
    if [ ! -f /tmpdatafiles/dump-0912 ]; then
        mkdir -p /tmpdatafiles
        tar xvjf /root/accidents-0912.tar.bz2 -C /tmpdatafiles
    fi
    echo "...unpacking done"

    echo "Try a restore..."
    #Should we do this with --drop ?
    #https://docs.mongodb.com/manual/reference/program/mongorestore/#cmdoption--drop
    mongorestore --numInsertionWorkersPerCollection 4 --port=$MONGOD_PORT /tmpdatafiles/dump-0912 && rm -rf /tmpdatafiles
    echo "...restore done"

    

    echo "...set up mongo cluster done"

    #fi

    /etc/mongo-shards-down

    touch /opt/mongo_shard_restore.done
fi

touch /opt/mongo_cluster.done
