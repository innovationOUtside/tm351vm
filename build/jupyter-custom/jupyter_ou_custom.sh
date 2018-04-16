#!/usr/bin/env bash

for PYTHONVER in 3 ; do
  PYTHON="python$PYTHONVER"
  PIP="pip$PYTHONVER"
  
  #Install utilities for notebook testing and export 
  $PIP install git+https://github.com/innovationOUtside/tm351_utils.git
  
  #Install ERD magic
  $PIP install git+https://github.com/innovationOUtside/ipython_magic_eralchemy.git

done

