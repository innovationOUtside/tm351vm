#!/usr/bin/env bash


export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

if [ ! -f /opt/tm351_py_stack.done  ]; then

    apt-get update && \
    apt-get install -y libpq-dev libgeos-dev libgdal-dev && \
    apt-get install -y libxml2-dev libxslt-dev && \
    apt-get install -y fonts-liberation && \
    apt-get clean

    $PIP install --upgrade pip

    # The TM351 python stack

    #http://initd.org/psycopg/articles/2018/02/08/psycopg-274-released/
    $PIPNC psycopg2-binary

    $PIPNC SQLAlchemy

    $PIPNC pymongo

    $PIPNC lxml

    $PIPNC cython
    $PIPNC openpyxl
    $PIPNC python-dateutil
    $PIPNC xlrd
    $PIPNC pygments
    $PIPNC pytz
    $PIPNC requests
    $PIPNC chardet
    $PIPNC messytables
    $PIPNC beautifulsoup4
    $PIPNC filemagic
    $PIPNC dataset
    $PIPNC six
    $PIPNC csvkit
    $PIPNC numpy
    $PIPNC numexpr
    $PIPNC tables
    $PIPNC pandas
    $PIPNC matplotlib
    $PIPNC nltk
    $PIPNC scipy
    $PIPNC scikit-learn

    $PIPNC pandasql

    #$PIPNC git+https://github.com/mccahill/ipython-sql.git
    #$PIPNC ipython-sql
    $PIPNC git+https://github.com/catherinedevlin/ipython-sql.git #https://github.com/undercertainty/tm351/issues/87
    $PIPNC pgspecial

    $PIPNC patsy
    $PIPNC fiona
    $PIPNC geopy
    $PIPNC descartes
    $PIPNC geopandas
    $PIPNC pygeoif
    $PIPNC fastkml
    $PIPNC folium
    $PIPNC shapely

    $PIPNC brewer2mpl
    $PIPNC mpld3
    $PIPNC statsmodels
    #PIPNC git+https://github.com/mwaskom/seaborn.git
    $PIPNC seaborn
    $PIPNC ggplot

    $PIPNC rdflib
    $PIPNC networkx
    $PIPNC sparqlwrapper

    $PIPNC ipythonblocks

    $PIPNC tqdm

    $PIPNC lunr
    $PIPNC pypdf2

    python3 -m nltk.downloader stopwords

    # Reduce the image size
    apt-get autoremove -y
    apt-get clean -y

    touch /opt/tm351_py_stack.done
fi



cd /
