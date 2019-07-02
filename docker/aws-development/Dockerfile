FROM alpine:3.9.4
LABEL maintainer="Steven Kiesling"

COPY build-boost.sh /build-boost.sh
COPY build-opencv.sh /build-opencv.sh
COPY build-protobuffers.sh /build-protobuffers.sh
COPY build-aws-runtime.sh /build-aws-runtime.sh

ENV TF_VERSION 0.12.1

RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n\
@edge http://nl.alpinelinux.org/alpine/edge/main\n\
@testing http://nl.alpinelinux.org/alpine/edge/testing\n\
@community http://dl-cdn.alpinelinux.org/alpine/edge/community'\
  >> /etc/apk/repositories

RUN apk --no-cache add --update \
  build-base \
  linux-headers \
  git \
  cmake \
  jq \
  # opencv
  libtbb@testing  \
  libtbb-dev@testing   \
  libjpeg  \
  libjpeg-turbo-dev \
  libpng-dev \
  jasper-dev \
  tiff-dev \
  libwebp-dev \
  freetype-dev \
  ffmpeg-dev \
  ffmpeg-libs \
  # boost
  curl \
  tar \
  # protobuffers
  autoconf \
  automake \
  libtool \
  unzip \
  # aws
  curl-dev \
  libexecinfo-dev \
  zlib-dev \
  zip \
  python3 \
  && pip3 install --upgrade pip \
  && pip install --no-cache-dir awscli \
  && rm -rf /var/cache/* \
  && rm -rf /var/cache/apk \
  && mkdir /var/cache/apk \
  && curl -L https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform.zip \
  && unzip terraform.zip \
  && chmod +x terraform \
  && mv terraform /usr/bin/terraform \
  && rm terraform.zip \
  && sh /build-boost.sh \
  && sh /build-opencv.sh \
  && sh /build-protobuffers.sh \
  && sh /build-aws-runtime.sh \
  && git clone https://github.com/weidai11/cryptopp.git \
  && cd cryptopp \
  && git checkout CRYPTOPP_8_2_0 \
  && make -j$(nproc) && make install \
  && cd ../ \
  && rm -rf cryptopp \
  && rm /build-boost.sh \
  && rm /build-opencv.sh \
  && rm /build-protobuffers.sh \
  && rm /build-aws-runtime.sh

CMD ["sh"]