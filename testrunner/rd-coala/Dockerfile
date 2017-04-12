FROM alpine:latest

LABEL maintainer "Sven <sven@testthedocs.org>" \
    org.label-schema.vendor = "TestTheDocs"

ENV PIP_CACHE /root/.cache

RUN builddeps=' \
        build-base \
        musl-dev \
        python3-dev \
        git \
        ' \
    apk add --no-cache musl \
        $builddeps \
        openssl \
        bash \
        python3 \
        ca-certificates \
        clang \
        tini \
        clang-libs \
        indent \
        nodejs \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade pip \
    && pip3 install coala \
    && pip3 install SpaceConsistencyBear \
    && pip3 install LineLengthBear \
    && pip3 install WriteGoodLintBear \
    && pip3 install reSTLintBear \
    && pip3 install LineCountBear \
    && rm -rf $PIP_CACHE \
    && npm install  -g \
        autoprefixer \
        bootlint \
        write-good \
        remark-cli \
    && npm cache clear \
    && apk del --purge $builddeps \
    && mkdir -p /srv/data

VOLUME /srv/data
WORKDIR /srv/data
ENTRYPOINT ["/sbin/tini", "--", "coala", "-c", "/srv/data/.coafile"]
