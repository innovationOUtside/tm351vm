#!/usr/bin/env bash

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -f /opt/pybase.done ]; then

      $PIPNC pip

      #The important thing in the following is to ensure the notebook style works
      #  with the extensions.
      #This means watching the notebook elements closely?
      #Allowing Jupyter machinery to upgrade should be okay?
      $PIPNC ipython-genutils
      $PIPNC jupyter-core
      $PIPNC nbformat

      $PIPNC ipython
      $PIPNC jupyter-client
      $PIPNC ipykernel

      $PIPNC notebook

      $PIPNC nbconvert

      $PIPNC jupyter-console
      $PIPNC jupyter

      $PIPNC jupyter-server-proxy

      $PIPNC nbdime

      $PIPNC mock
      $PIPNC jupytext

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
