#docker build --rm -t psychemedia/ou-tm351-minimal-test .

FROM ubuntu:16.04

MAINTAINER tony.hirst@gmail.com

ENV DOCKERBUILD 1

RUN apt-get autoremove && \
    apt-get -o Acquire::GzipIndexes=false update
RUN apt-get update && \
    apt-get upgrade -y \
    apt-get install -y apt-show-versions && \
    apt-get clean
