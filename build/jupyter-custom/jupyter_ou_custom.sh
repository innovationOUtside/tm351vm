#!/usr/bin/env bash


if [ ! -f /opt/jupyter_ou_custom.done ]; then

    #Graphviz for db magic
    apt-get -y update && apt-get install -y  python-dev graphviz libgraphviz-dev pkg-config
    
    
    #Install utilities for notebook testing and export 
    $PIP install git+https://github.com/innovationOUtside/tm351_utils.git
  
    #Install ERD magic
    #$PIP install git+https://github.com/psychemedia/eralchemy.git 
    #$PIP install git+https://github.com/innovationOUtside/ipython_magic_eralchemy.git
    $PIP install git+https://github.com/fschulze/sqlalchemy_schemadisplay.git
    $PIP install git+https://github.com/innovationOUtside/ipython_magic_sqlalchemy_schemadisplay.git


    touch /opt/jupyter_ou_custom.done
fi