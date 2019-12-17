ARG BASE=psychemedia/testpieces
FROM ${BASE}

MAINTAINER tony.hirst@gmail.com

RUN pip install jupyter-server-proxy

USER root
RUN chown oustudent:100 /openrefine_projects

USER oustudent
RUN jupyter serverextension enable --user jupyter_server_proxy
#USER root
USER $NB_UID
