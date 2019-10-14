#!/usr/bin/env bash

declare -a VERSIONS=('7.1-apache' '7.2-apache' '7.3-apache')

docker login docker.io

for i in "${VERSIONS[@]}"
do
  docker push unixslayer/php:$i
done
