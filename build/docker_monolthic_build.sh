# Shell script to build a monolithic docker container
#  containing all TM351 services

#The intention is to build a tier of docker containers
## that built up the TM351 environment in a sensible way

#TO DO
## Install python packages from a requirements.txt file
#pip install -U -r requirements.txt
#Python packages should be versioned
#For a "live" build, perhaps pip freeze then
## use the resulting list as requirements file?

#Define a stub to identify the images in this image stack
IMAGESTUB=psychemedia/tm361testm


# minimal
## Define a minimal container, eg a basic Linux container
## using whatever flavour of Linux we prefer
echo "Starting minimal build..."
docker build --rm -t ${IMAGESTUB}-minimal-test ./minimal

# base
## The base container installs core packages
## The intention is to define a common build environment
## populated with packages likely to be common to many courses
echo "Starting base build..."
docker build --rm --build-arg BASE=${IMAGESTUB}-minimal-test -t ${IMAGESTUB}-base-test ./base

# Jupyter base
## A minimal Jupyter environment
echo "Starting Jupyter base build..."
docker build --rm --build-arg BASE=${IMAGESTUB}-base-test -t ${IMAGESTUB}-jupyter-base-test ./jupyter-base

#Add in jupyter custom
## Add in Jupyter customisations
echo "Starting Jupyter custom build..."
docker build --rm --build-arg BASE=${IMAGESTUB}-jupyter-base-test -t ${IMAGESTUB}-jupyter-base-custom-test ./jupyter-custom
#docker build --rm --build-arg BASE=${IMAGESTUB}-jupyter-base-test -t psychemedia/testpieces ./jupyter-custom


#Add in pystack
## Add in a complete python environment relevant to a course
echo "Starting pystack build..."
docker build --rm --build-arg BASE=${IMAGESTUB}-jupyter-base-custom-test -t ${IMAGESTUB}-jupyter-base-custom-pystack-test ./pystack

#Add in postgres
## Add in a postgres database, populated with customisations for the course
#This could be split into two: postgres base and postgres custom?
echo "Starting postgres build..."
docker build --rm --build-arg BASE=${IMAGESTUB}-jupyter-base-custom-pystack-test -t ${IMAGESTUB}-jupyter-base-custom-pystack-postgres-test ./postgres
#docker build --rm --build-arg BASE=psychemedia/testpieces -t psychemedia/testpieces ./pystack

#Add in mongo-simple
echo "NOT Starting mongo build..."
#docker build --rm --build-arg BASE=${IMAGESTUB}-jupyter-base-custom-pystack-postgres-test -t ${IMAGESTUB}-jupyter-base-custom-pystack-postgres-mongo-test ./mongo
#docker build --rm --build-arg BASE=${IMAGESTUB}-jupyter-base-custom-pystack-postgres-test -t  psychemedia/testpieces ./mongo


#mongo sharded??

#Add in openrefine
echo "Starting openrefine build..."
docker build --rm --build-arg BASE=${IMAGESTUB}-jupyter-base-custom-pystack-postgres-mongo-test -t psychemedia/testpieces ./openrefine

#uses testpieces

#Add topup - test things to be moved elsewhere
echo "Starting topup build..."
docker build --rm --build-arg BASE=psychemedia/testpieces -t psychemedia/testpieces ./topup

#Add in supervisord
docker build --rm -t p/t .

#We can check running processes under supervisord with: supervisorctl
docker run -p 8899:8888 -p 8898:3334 -d p/t

#Error of the form:
#supervisord Included extra file "/etc/supervisor/conf.d/supervisord.conf" during parsing
#Check that supervisord is being run as root
