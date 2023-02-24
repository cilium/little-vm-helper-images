#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

GOLANG_VERSION=1.20.1
GOLANG_DOWNLOAD_URL=https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
GOLANG_DOWNLOAD_SHA256=000a5b1fca4f75895f78befeb2eecf10bfff3c428597f3f1e69133b63b911b02

curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
    && echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -xzf golang.tar.gz \
    && rm golang.tar.gz
