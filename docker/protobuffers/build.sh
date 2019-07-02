#!/bin/sh
set -e

git clone https://github.com/protocolbuffers/protobuf.git
cd protobuf
git checkout 3.8.x
git submodule update --init --recursive
./autogen.sh
./configure
make -j$(nproc) && make install
cd ..
rm -rf /protobuf
