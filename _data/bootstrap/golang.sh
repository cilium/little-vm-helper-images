#!/usr/bin/env bash
set -euxo pipefail

. /etc/profile

# renovate: datasource=golang-version depName=go
GOLANG_VERSION=1.25.0
GOLANG_DOWNLOAD_URL=https://golang.org/dl/go$GOLANG_VERSION.linux-$(dpkg --print-architecture).tar.gz

curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
    && tar -C /usr/local -xzf golang.tar.gz \
    && rm golang.tar.gz
