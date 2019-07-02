#!/bin/sh
set -e

if [ -z "$1" ]; then
  echo "usage: sh build-image.sh tag-name"
  exit 1
fi
cd $(dirname "$0")
cp ../boost/build.sh build-boost.sh
cp ../opencv/build.sh build-opencv.sh
cp ../protobuffers/build.sh build-protobuffers.sh
cp ../aws-runtime/build.sh build-aws-runtime.sh

docker build -t "$1" .

rm build-boost.sh
rm build-opencv.sh
rm build-protobuffers.sh
rm build-aws-runtime.sh
