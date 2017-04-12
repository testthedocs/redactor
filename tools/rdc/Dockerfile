FROM alpine:latest
LABEL maintainer "Sven <sven@testthedocs.org>" \
    org.label-schema.vendor = "TestTheDocs"

ENV PIP_CACHE /root/.cache

RUN builddeps=' \
    py2-pip \
    ' \
    && apk --no-cache add \
    $builddeps \
    python2 \
    make \
    py-setuptools \
    && pip install sphinx \
    guzzle_sphinx_theme \
    && apk del --purge $builddeps \
    && rm -rf $PIP_CACHE

VOLUME ["/build/docs"]

COPY config/conf /build/conf
COPY config/Makefile /build/Makefile

WORKDIR /build

ENTRYPOINT ["make"]
