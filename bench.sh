#!/usr/bin/env bash

declare -a VERSIONS=('7.1-fpm' '7.1-cli' '7.2-fpm' '7.2-cli')

for i in "${VERSIONS[@]}"
do
  docker run --rm -it -v $(pwd)/bench:/var/www/html unixslayer/php:$i php bench.php
done
