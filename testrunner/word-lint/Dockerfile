FROM alpine:latest
MAINTAINER sven <sven@testthedocs.org>

RUN apk --no-cache add \
    musl \
    openssl \
    bash \
    ca-certificates \
    grep

Add word-lint /srv/word-lint

WORKDIR /srv

# Make sure to check if tini [https://github.com/krallin/tini] could be useful
ENTRYPOINT ["/srv/word-lint"]

