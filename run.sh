#!/bin/sh

docker rmi resmonenv
docker build --tag resmonenv --no-cache . && docker run --rm -it -v "${PWD}":/app/ --name resmon resmonenv
