#!/bin/sh
set -e

git clone -b 3.4.4 https://github.com/opencv/opencv.git /opencv
git clone -b 3.4.4 https://github.com/opencv/opencv_contrib.git /opencv_contrib

mkdir /opencv/build
cd /opencv/build

cmake \
  -D CMAKE_BUILD_TYPE=RELEASE \
  -D INSTALL_C_EXAMPLES=OFF \
  -D INSTALL_PYTHON_EXAMPLES=OFF \
  -D WITH_TBB=ON \
  -D WITH_FFMPEG=ON \
  -D WITH_V4L=OFF \
  -D WITH_QT=OFF \
  -D WITH_OPENGL=OFF \
  -D OPENCV_PYTHON3_INSTALL_PATH="$1" \
  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
  -D BUILD_EXAMPLES=OFF ..

make -j$(nproc) && make install

cd ../../

rm -rf /opencv
rm -rf /opencv_contrib
