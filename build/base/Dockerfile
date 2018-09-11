#docker build --rm -t psychemedia/ou-tm351-base-test .


#To check inside this container, eg
#IMAGESTUB=psychemedia/tm361testm
#docker run -it --entrypoint=/bin/bash psychemedia/ou-tm351-base-test -i
#docker run -it --entrypoint=/bin/bash ${IMAGESTUB}-base-test -i

ARG BASE=psychemedia/ou-tm351-minimal-test
FROM ${BASE}

MAINTAINER tony.hirst@gmail.com

ENV DOCKERBUILD 1

#Is there a better way of setting these?
#Can't we pick them up from a profile file?
#They also need setting as late as possible
# so that we can reuse containers?
#Maybe just set defaults here that may get overwritten?
ENV MODULE_USER oustudent
ENV MODULE_UID 1351
ENV MODULE_GID 100

#Try and make things backward compatible
ENV TM351_USER $MODULE_USER
ENV TM351_UID $MODULE_UID
ENV TM351_GID $MODULE_GID

ENV NB_USER $TM351_USER
ENV NB_GID $TM351_GID


#Fix brokenness?
RUN apt-get -o Acquire::GzipIndexes=false update
RUN apt-get update && apt-get install -y apt-show-versions

# Base machine
ADD basepackages.sh  /tmp/basepackages.sh
ADD basepy.sh  /tmp/basepy.sh

RUN /tmp/basepackages.sh
RUN /tmp/basepy.sh


#User config - this is taken from monolithic
#Need a better build flow to handle course setup?
ADD settings.sh  /tmp/settings.sh
ADD version.sh  /version.sh

RUN /tmp/settings.sh

# Clean up from build
RUN rm -f /tmp/base*.sh
