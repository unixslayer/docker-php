#!/usr/bin/env bash

[ -z "$1" ] && printf "\n${red}Please specify container version (ex. 7.2-cli)${reset}\n\n" && exit

docker run -ti --rm unixslayer/php:"$@" bash -l
