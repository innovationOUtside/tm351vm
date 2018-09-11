#!/usr/bin/env bash

if [ ! -f /opt/jupyter_ou_tutor.done ]; then

  #Install utilities for notebook testing and export
  $PIP install nbgrader

  touch /opt/jupyter_ou_tutor.done
  
fi
