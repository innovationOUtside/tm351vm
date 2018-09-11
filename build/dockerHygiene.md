Remove exited containers

`docker ps -aq --no-trunc -f status=exited | xargs docker rm`

Delete untagged images

`docker rmi -f $(docker images | grep "^<none>" | awk "{print $3}")`

Look instide an image

`docker run -it --entrypoint=/bin/bash IMAGE -i`