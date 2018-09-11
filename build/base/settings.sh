#!/usr/bin/env bash

#This is taken from monolithic build
#for use in single docker container build

PIP="python3 -m pip"
export PIP

#Keep track of build datetime
$BUILDDIR/version.sh

#Create users
TM351_USER=oustudent
TM351_UID=1351
TM351_GID=100
export TM351_USER TM351_UID TM351_GID

echo "Adding service user: $TM351_USER"
useradd -m -s /bin/bash -N -u $TM351_UID $TM351_USER
#Add oustudent user to sudo group
usermod -a -G sudo oustudent

TM351_USER_HOME="$(getent passwd $TM351_USER | cut -d: -f6)"

#Note: the user is used to run Jupyter notebook and OpenRefine services
echo "..user added"

#Make Jupyter and OpenRefine users same as the tm351 user
NB_USER=$TM351_USER
NB_GID=$TM351_GID
export NB_USER NB_GID

OPENREFINE_USER=$TM351_USER
OPENREFINE_GID=$TM351_GID
export OPENREFINE_USER OPENREFINE_GID
#...done users


#PRESERVE ENVT VARS
ENV_VARS=/etc/profile.d/course_env.sh

#Note - for env vars to be available to py kernel in Jupyter notebook
# they need to be defined in the Jupyter service definition file
# Use: `Environment=MYENVVAR=/my/value` as part of `[Service]` definition.

echo "" >> $ENV_VARS
echo "# Environemnt variables for OU course user" >> $ENV_VARS
echo "TM351_USER=$TM351_USER" >> $ENV_VARS
echo "TM351_UID=$TM351_UID" >> $ENV_VARS
echo "TM351_USER=$TM351_USER" >> $ENV_VARS
echo "TM351_GID=$TM351_GID" >> $ENV_VARS
echo "NB_USER=$NB_USER" >> $ENV_VARS
echo "NB_GID=$NB_GID" >> $ENV_VARS
echo "OPENREFINE_USER=$OPENREFINE_USER" >> $ENV_VARS
echo "OPENREFINE_GID=$OPENREFINE_GID" >> $ENV_VARS
echo "" >> $ENV_VARS
