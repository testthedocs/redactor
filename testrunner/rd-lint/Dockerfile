FROM alpine:latest

LABEL maintainer "Sven <sven@testthedocs.org>" \
    architecture="amd64"

# Check if we can remove stuff after build
RUN apk --no-cache add \
    musl \
    openssl \
    bash \
    ca-certificates \
    grep

Add rd-lint /srv/rd-lint

WORKDIR /srv

# Make sure to check if tini [https://github.com/krallin/tini] could be useful
ENTRYPOINT ["/srv/rd-lint"]

