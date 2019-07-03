#!/usr/bin/env bash

declare -a VERSIONS=('5.6-apache' '7.1-cli' '7.1-fpm' '7.1-apache' '7.2-cli' '7.2-fpm' '7.2-apache')

docker login docker.io

for i in "${VERSIONS[@]}"
do
  docker push unixslayer/php:$i
done
