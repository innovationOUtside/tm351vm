

  504  docker build --rm --build-arg BASE=jupyter/minimal-notebook -t ${IMAGESTUB}-minimal-test ./minimal
  505  docker build --rm --build-arg BASE=${IMAGESTUB}-minimal-test -t ${IMAGESTUB}-base-test ./base

  512  docker build --rm --build-arg BASE=${IMAGESTUB}-base-test -t ${IMAGESTUB}-base-pystack-test ./pystack
  513  docker build --rm --build-arg BASE=${IMAGESTUB}-base-pystack-test -t ${IMAGESTUB}-base-pystack-postgres-test ./postgres
  515  docker build --rm --build-arg BASE=${IMAGESTUB}-base-pystack-postgres-test -t psychemedia/test2 ./openrefine
  519  docker build --rm --build-arg BASE=psychemedia/test2 -t psychemedia/test3 ./topup-jh
  520  docker push psychemedia/test3


  533  cd
  534  cd Documents/demos/datamanagement-notebook/
  535  ls
  536  mv Dockerfile.txt Dockerfile
  537  docker build --rm -t psychemedia/dmn-delme .
  538  docker build --rm -t psychemedia/dmn-delme .
  539  docker build --rm -t psychemedia/dmn-delme .
  540  docker push psychemedia/dmn-delme
  541  docker images
 

