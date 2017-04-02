FROM alpine:latest
LABEL maintainer "Sven <sven@testthedocs.org>"

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
        ca-certificates \
        python3 \
        clang \
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
    && apk del --purge $builddeps

WORKDIR /srv
#ENTRYPOINT ["coala"]
ENTRYPOINT ["coala", "-c", "/srv/.coafile"]
#ENTRYPOINT ["bash"]
