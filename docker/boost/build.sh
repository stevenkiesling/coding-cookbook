#!/bin/sh
set -e

BOOST_VERSION=1.70.0
BOOST_CHECKSUM=882b48708d211a5f48e60b0124cf5863c1534cd544ecd0664bb534a4b5d506e9
BOOST_DIR=boost

mkdir -p ${BOOST_DIR}
cd ${BOOST_DIR}
curl -L --retry 3 "https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_1_70_0.tar.gz" -o boost.tar.gz
echo "${BOOST_CHECKSUM}  boost.tar.gz" | sha256sum -c
tar -xzf boost.tar.gz --strip 1
./bootstrap.sh
./b2 --without-python --prefix=/usr -j$(nproc) link=shared runtime-link=shared install
cd ..
rm -rf ${BOOST_DIR}
