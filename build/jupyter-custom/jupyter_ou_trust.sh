#!/usr/bin/env bash

#Path to shared notebook directory
NBDIRECTORY=/vagrant/notebooks

if  [ -d "$NBDIRECTORY" ]; then

    # Trust notebooks in notebook directory
    files=(`find $NBDIRECTORY -maxdepth 1 -name "*.ipynb"`)
    if [ ${#files[@]} -gt 0 ]; then
        jupyter trust $NBDIRECTORY/*.ipynb;
    fi
    
    # Trust notebooks in immediate child directories of notebook directory
    files=(`find $NBDIRECTORY/* -maxdepth 1 -name "*.ipynb"`)
    if [ ${#files[@]} -gt 0 ]; then
        jupyter trust $NBDIRECTORY/*/*.ipynb;
    fi

fi
