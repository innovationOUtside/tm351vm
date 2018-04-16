#!/usr/bin/env bash

for PYTHONVER in 3 ; do
  PYTHON="python$PYTHONVER"
  PIP="pip$PYTHONVER"
  
  #Go for the easy option and src all the jupyter_contrib_nbextensions 
  $PIP install jupyter_contrib_nbextensions
  $PIP install RISE
  
done


jupyter contrib nbextension install --system

#Enable certain extensions from the start
jupyter nbextension enable freeze/main
jupyter nbextension enable highlighter/highlighter
jupyter nbextension enable spellchecker/main
jupyter nbextension enable collapsible_headings/main
jupyter nbextension enable codefolding/main
jupyter nbextension enable rubberband/main
jupyter nbextension enable exercise/main
jupyter nbextension enable python-markdown/main

jupyter nbextension enable skip-traceback/main
jupyter nbextension enable hide_input/main
jupyter nbextension enable init_cell/main

#Slideshow
jupyter-nbextension install rise --py --sys-prefix
jupyter-nbextension enable rise --py --sys-prefix


#If not the Docker build, set up the services
if [[ -z "${DOCKERBUILD}" ]]; then
	#restart the service
	systemctl restart jupyter.service
fi