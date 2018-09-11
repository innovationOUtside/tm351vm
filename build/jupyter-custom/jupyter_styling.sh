#!/bin/bash -e

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

JUPYTERSRC=${THISDIR}/jupyter_custom_files

# EVERYTHING BELOW HERE SHOULD JUST WORK....


#------- PROFILE: tm351MT -------
#------- Jupyter does not have a notion of profiles -------

###

echo "Trying to make use of appropriate NB_USER: $NB_USER"

IPYTHONDIR=$(runuser -l $NB_USER -c '/usr/local/bin/ipython locate')
echo "Trying to make use of appropriate user IPYTHONDIR: $IPYTHONDIR"

JUPYTERDATADIR=$(runuser -l $NB_USER -c '/usr/local/bin/jupyter --data-dir')
JUPYTERCONFIGDIR=$(runuser -l $NB_USER -c '/usr/local/bin/jupyter --config-dir')
echo "Locating Jupyter directories..."
echo "   - JUPYTERDATADIR: $JUPYTERDATADIR"
echo "   - JUPYTERCONFIGDIR: $JUPYTERCONFIGDIR"

echo "Ensuring default jupyter directories available"
#Ensure directories are available
mkdir -p $JUPYTERDATADIR
chown $NB_USER:$NB_GID $JUPYTERDATADIR
mkdir -p $JUPYTERCONFIGDIR
chown $NB_USER:$NB_GID $JUPYTERCONFIGDIR

#These directories are where the original source files are located for the build
TM351CUSTOMFILEPATH=$JUPYTERSRC/custom
TM351NBCONFIGFILEPATH=$JUPYTERSRC/nbconfig
TM351TPLTEMPLATESFILEPATH=$JUPYTERSRC/templates



#Directories on the VM that need to exist
TPLTEMPLATES=$JUPYTERDATADIR/templates #not sure about this
CUSTOMISATIONS=$JUPYTERCONFIGDIR/custom

echo "Ensuring required jupyter sub-directories available"

echo "Creating TPLTEMPLATES: $TPLTEMPLATES..."
mkdir -p $TPLTEMPLATES
chown $NB_USER:$NB_GID $TPLTEMPLATES

echo "Creating CUSTOMISATIONS: $CUSTOMISATIONS..."
mkdir -p $CUSTOMISATIONS
chown $NB_USER:$NB_GID $CUSTOMISATIONS


#Startup files
STARTUP=$IPYTHONDIR/profile_default/startup
echo "Ensuring jupyter startup files available: STARTUP: $STARTUP"
mkdir -p $STARTUP
cp -p $TM351CUSTOMFILEPATH/tm351_start.ipy $STARTUP/tm351_start.ipy
chown $NB_USER:$NB_GID $STARTUP

#Styling and branding extensions
echo "Ensuring jupyter customisation files available"
cp -p $TM351CUSTOMFILEPATH/* $JUPYTERCONFIGDIR/custom/
chown -R $NB_USER:$NB_GID $JUPYTERCONFIGDIR/custom/

#nbconvert templating extensions
echo "Ensuring jupyter template extension files available"
cp -p -r $TM351TPLTEMPLATESFILEPATH/* $TPLTEMPLATES/
chown -R $NB_USER:$NB_GID $TPLTEMPLATES

echo "...done with custom styling"

#If not the Docker build, set up the services
if [[ -z "${DOCKERBUILD}" ]]; then
	systemctl restart jupyter.service
fi
