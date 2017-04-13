FROM alpine:latest

LABEL maintainer "Sven <sven@testthedocs.org>" \
	org.label-schema.vendor = "TestTheDocs"

ENV PIP_CACHE /root/.cache

RUN builddeps=' \
	python3-dev \
	openssl-dev \
	py-pip \
	musl-dev \
	openssl-dev \
	libffi-dev \
	gcc \
	' \
	&& apk --no-cache add \
	ca-certificates \
	python3 \
	py-httplib2 \
	bash \
	make \
	tini \
	$builddeps \
	&& python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade pip \
	&& pip install sphinx \
	&& apk del --purge $builddeps \
	&& mkdir -p /srv/data

VOLUME /build/docs

COPY config/conf /build/conf
COPY config/Makefile /build/Makefile

WORKDIR /build
ENTRYPOINT ["/sbin/tini", "--", "make"]




