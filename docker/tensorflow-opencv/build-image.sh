#!/bin/sh
set -e

if [ -z "$1" ]; then
  echo "usage: sh build-image.sh tag-name"
  exit 1
fi
cd $(dirname "$0")
cp ../opencv/build.sh build-opencv.sh
docker build -t "$1" .
rm build-opencv.sh
