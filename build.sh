#!/usr/bin/env bash

BUILD_VERSION='7.4-apache'
BUILD_CMD=${0##*/}
BUILD_HTTP_PROXY=${http_proxy}
BUILD_HTTPS_PROXY=${https_proxy}
BUILD_NAMESPACE="unixslayer"
BUILD_NO_PROXY=0
BUILD_OPTIONS=""

echoerr() { echo "$@" 1>&2; }

usage()
{
    cat << USAGE >&2
Usage:
    $BUILD_CMD [-v version] [--http-proxy proxy] [--https-proxy proxy] [-- build options]

    -v | --version              Version to build (default: $BUILD_VERSION). Available versions are: 5.6-apache, 7.1-apache, 7.1-cli, 7.1-fpm, 7.2-apache, 7.2-cli, 7.2-fpm, 7.3-apache, 7.4-apache
    -n | --namespace            Namespace of docker image (<namespace>/php:<version>)

    -- build options            Additional docker build options

    By default script will use your local http(s)_proxy variable if it is defined. This option lets you override it for build purpose. Value will be passed into docker build command.

    --no-proxy                  Ignore proxy
    --http-proxy                Sets http_proxy
    --https-proxy               Sets https_proxy

USAGE
    exit 1
}

build()
{
    BUILD_ARGS=""

    if [[ $BUILD_NO_PROXY == 0 && $BUILD_HTTP_PROXY != "" ]]; then
        BUILD_ARGS="${BUILD_ARGS} --build-arg http_proxy=${BUILD_HTTP_PROXY}"
    fi

    if [[ $BUILD_NO_PROXY == 0 && $BUILD_HTTPS_PROXY != "" ]]; then
        BUILD_ARGS="${BUILD_ARGS} --build-arg https_proxy=${BUILD_HTTPS_PROXY}"
    fi

    docker build ${BUILD_ARGS} -t ${BUILD_NAMESPACE}/php:${BUILD_VERSION} ./dist/${BUILD_VERSION} ${BUILD_OPTIONS}
}

while [[ $# -gt 0 ]]
do
    case "$1" in
        --)
        shift
        BUILD_OPTIONS=("$@")
        break
        ;;
        -v | --version)
        BUILD_VERSION="$2"
        if [[ $BUILD_VERSION == "" ]]; then echoerr "Version cannot be blank";break; fi
        shift 2
        ;;
        -n | --namespace)
        BUILD_NAMESPACE="$2"
        if [[ BUILD_NAMESPACE == "" ]]; then echoerr "Namespace cannot be blank";break; fi
        shift 2
        ;;
        --http-proxy)
        BUILD_HTTP_PROXY="$2"
        shift 2
        ;;
        --https-proxy)
        BUILD_HTTPS_PROXY="$2"
        shift 2
        ;;
        --no-proxy)
        BUILD_NO_PROXY=1
        shift 1
        ;;
        -h | --help)
        usage
        ;;
        *)
        echoerr "Unknown argument: $1"
        usage
        ;;
    esac
done

build