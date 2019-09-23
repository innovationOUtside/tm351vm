#!/bin/bash -e

echo "Installing bundler extensions..."

if [ ! -f /opt/jupyter_extensions.done ]; then

      echo "...wordexport install..."
      #Install the wordexport (.docx exporter) extension package
      $PIPNC git+https://github.com/innovationOUtside/nb_extension_wordexport.git

      jupyter bundlerextension enable --py wordexport.wordexport --sys-prefix
      echo "...wordexport done"

      echo "...odszip install..."
      #Install the ODSzip extension package
      $PIPNC git+https://github.com/innovationOUtside/nb_extension_odszip.git
      jupyter bundlerextension enable --py odszip.download --sys-prefix
      #echo "...odszip done"

      $PIPNC git+https://github.com/innovationOUtside/nb_workflow_tools.git

    touch /opt/jupyter_extensions.done
fi

echo "...done bundler extensions"

#restart the service
sudo systemctl restart jupyter.service
