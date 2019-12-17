ARG BASE=psychemedia/testpieces
FROM ${BASE}

MAINTAINER tony.hirst@gmail.com

USER $NB_UID

RUN pip install nbserverproxy

RUN jupyter serverextension enable --py nbserverproxy
#USER root
