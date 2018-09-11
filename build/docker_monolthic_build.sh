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
docker build --rm -t ${IMAGESTUB}-minimal-test ./minimal

# base
## The base container installs core packages
## The intention is to define a common build environment
## populated with packages likely to be common to many courses
docker build --rm --build-arg BASE=${IMAGESTUB}-minimal-test -t ${IMAGESTUB}-base-test ./base
