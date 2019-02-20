#!/usr/bin/env bash

declare -a VERSIONS=('7.1-fpm' '7.1-cli' '7.2-fpm' '7.2-cli')

for i in "${VERSIONS[@]}"
do
  VERSION=${i: 0:3}
  ENV=${i: -3}
  source ./env/${VERSION}.env
  rm -rf ./dist/$i
  mkdir -p ./dist/$i
  cp -R ./conf/${ENV} ./dist/$i/conf/
  cp -R ./bin/${ENV} ./dist/$i/bin
  cp Dockerfile ./dist/$i/Dockerfile
  sed -i "s/\$VERSION/$i/g" ./dist/$i/Dockerfile
  sed -i "s/\$MCRYPT_VERSION/${MCRYPT_VERSION}/g" ./dist/$i/Dockerfile
  docker build -t unixslayer/php:$i ./dist/$i
done
