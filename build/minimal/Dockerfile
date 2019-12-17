#docker build --rm -t psychemedia/ou-tm351-minimal-test .

ARG BASE=ubuntu:18.04
FROM ${BASE}

USER root

MAINTAINER tony.hirst@gmail.com

ENV DOCKERBUILD 1
ENV PIPNC="python3 -m pip install --no-cache-dir"

RUN apt-get autoremove && \
    apt-get -o Acquire::GzipIndexes=false update
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apt-show-versions && \
    apt-get clean
