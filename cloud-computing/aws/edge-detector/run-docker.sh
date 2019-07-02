#!/bin/sh
set -e

if [ -z $1 ]; then
  echo "usage: sh run-docker.sh package | deploy | test | destroy"
else
  PROJECTDIR=$(dirname "$0")/../../../
  if [ -z "$(docker images -q aws-development:1)" ]; then
    echo "image: aws-development:1 does not exist. building image aws-development:1"
    sh $PROJECTDIR/docker/aws-development/build-image.sh "aws-development:1"
  fi
  cd "$PROJECTDIR"
  docker run --rm -it -v $PWD:/code -v $HOME/.aws:/root/.aws --entrypoint "sh" aws-development:1 /code/cloud-computing/aws/edge-detector/deploy.sh $@
fi