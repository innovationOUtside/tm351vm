#docker build --rm -t psychemedia/ou-tm351-postgres-test .
#docker build --rm --build-arg BASE=etc -t psychemedia/ou-tm351-postgres-test .

ARG BASE=psychemedia/ou-tm351-minimal-test
# Base machine
FROM ${BASE}


ENV DOCKERBUILD 1

#Install postgres and any other required packages
ADD postgresql.sh /tmp/postgres/postgresql.sh
WORKDIR /tmp/postgres/
RUN ./postgresql.sh
WORKDIR /
#Tidy up
RUN rm -rf /tmp/postgres

#Run any Postgres database seeding / config routines
ADD config/config_tm351.sql /tmp/postgres/config/config_tm351.sql
USER postgres
#We need to make sure the postgres service is running
# before we try to use it...
RUN service postgresql restart  && \
      psql -f /tmp/postgres/config/config_tm351.sql && \
      service postgresql stop 

#Reset to root user for other build steps
USER root
