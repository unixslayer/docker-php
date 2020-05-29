#!/bin/bash
set -e

TINI_VERSION=${TINI_VERSION:-v0.17.0}

if [[ ${http_proxy} != "" ]]; then
  pear config-set http_proxy ${http_proxy}
  export http_proxy=${http_proxy}
fi

if [[ ${https_proxy} != "" ]]; then
  export https_proxy=${https_proxy}
fi

curl --location --output /sbin/tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini && chmod +x /sbin/tini

a2enmod rewrite status headers unique_id
