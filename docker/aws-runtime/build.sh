#!/bin/sh
set -e

git clone https://github.com/awslabs/aws-lambda-cpp.git
cd aws-lambda-cpp
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc) && make install
cd ../../
rm -rf aws-lambda-cpp
