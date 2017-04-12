#
# Dockerfile for Caddy https://caddyserver.com/
# Addopted from https://github.com/abiosoft/caddy-docker
#
FROM alpine:latest

LABEL maintainer "Sven <sven@testthedocs.org>" \
    org.label-schema.vendor = "TestTheDocs" \
    caddy_version="0.9.5" \
    architecture="amd64"

RUN builddeps=' \
        tar \
        curl \
        '\
        && apk --no-cache add \
        $builddeps \
        git \
        tini \
        openssh-client \
	&& curl --silent --show-error --fail --location \
		--header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
		"https://caddyserver.com/download/build?os=linux&arch=amd64&features=minify" \
	| tar --no-same-owner -C /usr/bin/ -xz caddy \
	&& chmod 0755 /usr/bin/caddy \
        && /usr/bin/caddy -version \
        && apk del --purge $builddeps

EXPOSE 80 443 2015
WORKDIR /srv

ADD tools/rd-docs/Caddyfile /etc/Caddyfile
ADD docs/_build/html /srv/html

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile"]
