#!/usr/bin/env bash
set -e

if [[ ${http_proxy} != "" ]]; then
  pear config-set http_proxy ${http_proxy}
  export http_proxy=${http_proxy}
fi

if [[ ${https_proxy} != "" ]]; then
  export https_proxy=${https_proxy}
fi
