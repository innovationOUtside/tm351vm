#docker build --rm -t psychemedia/ou-tm351-jupyter-custom-pystack-test .
#docker run -it --entrypoint=/bin/bash ${IMAGESTUB}-jupyter-custom-pystack-test -i


# call by adding --build-arg <varname>=<value>
ARG BASE=psychemedia/ou-tm351-jupyter-custom-test
FROM ${BASE}

MAINTAINER tony.hirst@gmail.com

ENV DOCKERBUILD 1

# Base machine

#Build the Jupyter server
ADD build_tm351_stack.sh /tmp/jupyter/build_tm351_stack.sh

RUN /tmp/jupyter/build_tm351_stack.sh


RUN rm -rf /tmp/jupyter
