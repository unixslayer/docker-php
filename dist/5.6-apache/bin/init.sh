#!/bin/bash
set -e

TINI_VERSION=${TINI_VERSION:-v0.17.0}

CURL_ARGS=""

if [[ -n ${http_proxy} ]]; then
  CURL_ARGS="${CURL_ARGS} -x ${http_proxy}"
fi

curl ${CURL_ARGS} --location --output /sbin/tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini && chmod +x /sbin/tini
