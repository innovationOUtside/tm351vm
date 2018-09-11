#docker run -it --entrypoint=/bin/bash ${IMAGESTUB}-jupyter-base-test -i

ARG BASE=psychemedia/ou-tm351-minimal-test
# Base machine
FROM ${BASE}

MAINTAINER tony.hirst@open.ac.uk

ENV DOCKERBUILD 1
#ENV MODULE_USER oustudent

#Install mongo
ADD mongo.sh /tmp/mongo/mongo.sh
WORKDIR /tmp/mongo/
RUN ./mongo.sh
WORKDIR /
#Tidy up
RUN rm -rf /tmp/mongo

#Add the mongodb group permission to the module user
RUN usermod -a -G mongodb $MODULE_USER

RUN mkdir -p /tmpdatafiles
#ADD unzips automatically...
COPY simple/data/small_accidents.tar.bz2 /root/small_accidents.tar.bz2
RUN tar xvjf /root/small_accidents.tar.bz2 -C /tmpdatafiles

#Seed the database
USER mongodb
RUN /usr/bin/mongod --dbpath=/var/lib/mongodb --port=27351 --fork --syslog && sleep 5 && mongorestore --drop --db accidents --port=27351 /tmpdatafiles/small_accidents


USER root
WORKDIR /
