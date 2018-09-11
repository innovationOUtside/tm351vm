#docker build --rm -t psychemedia/ou-tm351-jupyter-base-test .


#To check inside this container, eg
#docker run -it --entrypoint=/bin/bash psychemedia/ou-tm351-jupyter-base-test -i
#docker run -it --entrypoint=/bin/bash ${IMAGESTUB}-jupyter-base-test -i


# call by adding --build-arg <varname>=<value>
ARG BASE=psychemedia/ou-tm351-base-test
FROM ${BASE}

MAINTAINER tony.hirst@gmail.com

#The docker build doesn't pick this env var up?
ENV PIP="python3 -m pip"

ENV DOCKERBUILD 1

# Base machine

#Build the Jupyter server
ADD build_jupyter.sh /tmp/jupyter/build_jupyter.sh
ADD config /tmp/jupyter/config

RUN /tmp/jupyter/build_jupyter.sh
RUN rm -rf /tmp/jupyter

RUN mkdir -p /notebooks
RUN chown oustudent:100 /notebooks
VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888


CMD su - oustudent -c "/usr/local/bin/jupyter notebook --ip=0.0.0.0 --y --log-level=WARN --no-browser --notebook-dir=/notebooks"
