#!/bin/bash -e

echo "Installing bundler extensions..."

if [ ! -f /opt/jupyter_extensions.done ]; then

    apt-get update && apt-get install -y pandoc && \
    apt-get clean

    for PYTHONVER in 3 ; do

      PYTHON="python$PYTHONVER"
      PIP="pip$PYTHONVER"
      #https://stackoverflow.com/questions/49836676/python-pip3-cannot-import-name-main
      PIP="python3 -m pip"

      echo "...wordexport install..."
      #Install the wordexport (.docx exporter) extension package
      $PIP install git+https://github.com/innovationOUtside/nb_extension_wordexport.git

      jupyter bundlerextension enable --py wordexport.wordexport --sys-prefix
      echo "...wordexport done"

      echo "...odszip install..."
      #Install the ODSzip extension package
      $PIP install git+https://github.com/innovationOUtside/nb_extension_odszip.git
      jupyter bundlerextension enable --py odszip.download --sys-prefix
      #echo "...odszip done"

      $PIP install git+https://github.com/innovationOUtside/nb_workflow_tools.git

    done
    touch /opt/jupyter_extensions.done
fi

echo "...done bundler extensions"

#restart the service
sudo systemctl restart jupyter.service
