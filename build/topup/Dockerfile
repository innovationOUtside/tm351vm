ARG BASE=psychemedia/testpieces
FROM ${BASE}

MAINTAINER tony.hirst@gmail.com

RUN $PIP install jupyterhub

USER root
RUN chown oustudent:100 /openrefine_projects

USER oustudent
RUN jupyter serverextension enable --py nbserverproxy
#USER root
USER $NB_UID
