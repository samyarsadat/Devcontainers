#!/usr/bin/env bash

# shellcheck disable=SC2034
FEATURE_SHARE="/usr/local/share/dev-environments"
FEATURE_LIB="/usr/local/lib/dev-environments"
FEATURE_BIN="/usr/local/bin"

die() {
    printf "dev-environments: %s\n" "$*" >&2
    exit 1
}

apt_install() {
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y --no-install-recommends "$@"
}

apt_cleanup() {
    apt-get clean
    rm -rf /var/lib/apt/lists/*
}
