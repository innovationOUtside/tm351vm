#!/bin/bash -e

echo "Installing Jupyterlab..."

if [ ! -f /opt/jupyter_lab.done ]; then
  
    for PYTHONVER in 3 ; do

      PYTHON="python$PYTHONVER"
      PIP="pip$PYTHONVER"
      #https://stackoverflow.com/questions/49836676/python-pip3-cannot-import-name-main
      PIP="python3 -m pip"

      $PIP install jupyterlab
      jupyter serverextension enable --py jupyterlab --sys-prefix

      #TO DO - service file; start optionally from Vagrantfile?

    done
    touch /opt/jupyter_lab.done
fi

echo "...done Jupyterlab"

#restart the service
#sudo systemctl restart jupyterlab.service
