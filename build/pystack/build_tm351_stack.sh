#!/usr/bin/env bash


export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

if [ ! -f /opt/tm351_py_stack.done  ]; then

    apt-get update && \
    apt-get install -y libpq-dev libgeos-dev libgdal-dev && \
    apt-get install -y libxml2-dev libxslt-dev && \
    apt-get install -y fonts-liberation && \
    apt-get clean


    for PYTHONVER in 3 ; do
      PYTHON="python$PYTHONVER"
      PIP="pip$PYTHONVER"
      #https://stackoverflow.com/questions/49836676/python-pip3-cannot-import-name-main
      PIP="python3 -m pip"
      PIPINC = "python3 -m pip install --no-cache-dir"


      $PIP install --upgrade pip

      # The TM351 python stack

      #http://initd.org/psycopg/articles/2018/02/08/psycopg-274-released/
      $PIPINC psycopg2-binary

      $PIPINC SQLAlchemy

      $PIPINC pymongo

      $PIPINC lxml

      $PIPINC cython
      $PIPINC openpyxl
      $PIPINC python-dateutil
      $PIPINC xlrd
      $PIPINC pygments
      $PIPINC pytz
      $PIPINC requests
      $PIPINC chardet
      $PIPINC messytables
      $PIPINC beautifulsoup4
      $PIPINC filemagic
      $PIPINC dataset
      $PIPINC six
      $PIPINC csvkit
      $PIPINC numpy
      $PIPINC numexpr
      $PIPINC tables
      $PIPINC pandas
      $PIPINC matplotlib
      $PIPINC nltk
      $PIPINC scipy
      $PIPINC scikit-learn

      $PIPINC install pandasql

      #$PIPINC git+https://github.com/mccahill/ipython-sql.git
      #$PIPINC ipython-sql
      $PIPINC git+https://github.com/catherinedevlin/ipython-sql.git #https://github.com/undercertainty/tm351/issues/87
      $PIPINC pgspecial

      $PIPINC patsy
      $PIPINC fiona
      $PIPINC geopy
      $PIPINC descartes
      $PIPINC geopandas
      $PIPINC pygeoif
      $PIPINC fastkml
      $PIPINC folium
      $PIPINC shapely

      $PIPINC brewer2mpl
      $PIPINC mpld3
      $PIPINC statsmodels
      #PIPINC git+https://github.com/mwaskom/seaborn.git
      $PIPINC seaborn
      $PIPINC ggplot

      $PIPINC rdflib
      $PIPINC networkx
      $PIPINC sparqlwrapper

      $PIPINC ipythonblocks

      $PIPINC tqdm

      $PIPINC lunr
      $PIPINC pypdf2

    done

    python3 -m nltk.downloader stopwords

    # Reduce the image size
    apt-get autoremove -y
    apt-get clean -y

    touch /opt/tm351_py_stack.done
fi



cd /
