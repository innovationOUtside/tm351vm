#!/bin/bash -e

echo ""
echo ""
echo "**************************************************************"
echo "*************       Setting up PostgreSQL        *************"
echo "**************************************************************"
echo ""
echo ""

if [ ! -f /opt/postgresql.done ]; then
    THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


    #Install postgres packages
    apt-get update && \
    apt-get install -y postgresql postgresql-client && \
    #Additionally bring in command line tools to help with data grab
    apt-get install -y curl zip unzip bzip2 wget && \
    apt-get clean

    #If not the Docker build, set up the initial database
    #Handle it in the dockerfile instead
    if [[ -z "${DOCKERBUILD}" ]]; then
          #I don't this works in Docker build?
        sudo su - postgres <<-EOF
            psql -f ${THISDIR}/config/config_tm351.sql
EOF
    fi

    #Should maybe move to a model where we run a test
    # If test passes, then set done?
    touch /opt/postgresql.done
fi

echo ""
echo ""
echo "**************************************************************"
echo "*************    DONE: setting up PostgreSQL     *************"
echo "**************************************************************"
echo ""
echo ""
