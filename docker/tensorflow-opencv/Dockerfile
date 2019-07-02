FROM tensorflow/tensorflow:1.13.1-py3 as builder
LABEL maintainer="Steven Kiesling"

COPY build-opencv.sh /

RUN apt-get update && apt install --no-install-recommends -y \
  rsync \
  cmake \
  git \
  gfortran \
  libjpeg8-dev \
  libpng-dev \
  software-properties-common \
  && add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" \
  && apt update && apt install --no-install-recommends -y \
  libjasper1 \
  libtiff-dev \
  libavcodec-dev \
  libavformat-dev \
  libswscale-dev \
  libdc1394-22-dev \
  libxine2-dev \
  libv4l-dev \
  && cd /usr/include/linux \
  && ln -s -f ../libv4l1-videodev.h videodev.h \
  && cd / \
  apt install --no-install-recommends -y \
  libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libgtk2.0-dev libtbb-dev \
  libatlas-base-dev \
  libfaac-dev \
  libmp3lame-dev \
  libtheora-dev \
  libvorbis-dev \
  libxvidcore-dev \
  libopencore-amrnb-dev \
  libopencore-amrwb-dev \
  libavresample-dev \
  x264 \
  v4l-utils \
  && sh /build-opencv.sh "/usr/local/lib/python3.5/dist-packages" \
  && /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf' \
  && ldconfig \
  && rm /build-opencv.sh

  CMD ["bash"]