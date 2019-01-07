#!/usr/bin/env bash

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -f /opt/pybase.done ]; then

    #for PYTHONVER in 3 ; do
    #  PYTHON="python$PYTHONVER"
      #PIP="pip$PYTHONVER"
    #  PIP="pip"
      #https://stackoverflow.com/questions/49836676/python-pip3-cannot-import-name-main
      #PIP="python3 -m pip"

      $PIP install --upgrade pip

      #The important thing in the following is to ensure the notebook style works
      #  with the extensions.
      #This means watching the notebook elements closely?
      #Allowing Jupyter machinery to upgrade should be okay?
      $PIP install --no-cache-dir ipython-genutils
      $PIP install --no-cache-dir jupyter-core
      $PIP install --no-cache-dir nbformat

      $PIP install --no-cache-dir ipython
      $PIP install --no-cache-dir jupyter-client
      $PIP install --no-cache-dir ipykernel

      $PIP install --no-cache-dir notebook

      $PIP install --no-cache-dir nbconvert

      $PIP install --no-cache-dir jupyter-console
      $PIP install --no-cache-dir jupyter

      $PIP install --no-cache-dir nbdime

    #done
    touch /opt/pybase.done
fi


#Define a custom config dir
JUPYTERCONFIGDIR=$(/usr/local/bin/jupyter --config-dir)
mkdir -p $JUPYTERCONFIGDIR

cp $THISDIR/config/jupyter_notebook_config.py $JUPYTERCONFIGDIR/jupyter_notebook_config.py

#If not the Docker build, set up the services
if [[ -z "${DOCKERBUILD}" ]]; then

	if [[ -z "${AUTHBUILD}" ]]; then
		cp $THISDIR/services/jupyter.service /lib/systemd/system/jupyter.service
        cp $THISDIR/services/nbdime.service /lib/systemd/system/nbdime.service

	else
		#Secure setup
		cp $THISDIR/services/jupyter_auth.service /lib/systemd/system/jupyter.service
		#Override the config
		cp $THISDIR/config/jupyter_notebook_config_auth.py $JUPYTERCONFIGDIR/jupyter_notebook_config.py
	fi

	# Enable autostart
	systemctl enable jupyter.service
	systemctl enable nbdime.service

	# Refresh service config
	systemctl daemon-reload

	#(Re)start service
	systemctl restart jupyter.service
	systemctl restart nbdime.service
fi
