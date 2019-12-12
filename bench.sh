#!/usr/bin/env bash

declare -a VERSIONS=('7.1-apache' '7.2-apache' '7.3-apache' '7.4-apache')

for i in "${VERSIONS[@]}"
do
  docker run --rm -it -v $(pwd)/bench:/var/www/html unixslayer/php:$i php bench.php
done
