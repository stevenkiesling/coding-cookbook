FROM alpine:3.9.4
LABEL maintainer="Steven Kiesling"

COPY build.sh /

RUN apk --no-cache add --virtual .build-dependencies \
	build-base \
	linux-headers \
	cmake \
  git \
  curl-dev \
  libexecinfo-dev \
  zlib-dev && \
  sh build.sh && \
  apk del .build-dependencies && \
  rm -rf /var/cache/*

CMD ["sh"]