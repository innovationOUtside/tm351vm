#!/bin/bash -e

apt-get install -y pandoc && apt-get clean

echo "Installing bundler extensions..."


for PYTHONVER in 3 ; do

  PYTHON="python$PYTHONVER"
  PIP="pip$PYTHONVER"
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

done


echo "...done bundler extensions"

#restart the service
sudo systemctl restart jupyter.service