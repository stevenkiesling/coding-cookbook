FROM alpine:3.9.4
LABEL maintainer="Steven Kiesling"

COPY build.sh /

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
    && rm -rf /var/cache/* \
		&& sh /build.sh

CMD ["sh"]
