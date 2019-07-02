FROM alpine:3.9.4
LABEL maintainer="Steven Kiesling"

RUN apk --no-cache add --virtual .build-dependencies \
    build-base \
    linux-headers \
    autoconf \
    automake \
    libtool \
    curl \
    unzip \
    git \
    && sh build.sh \
    && apk del .build-dependencies \
    && rm -rf /var/cache/*

CMD ["sh"]
