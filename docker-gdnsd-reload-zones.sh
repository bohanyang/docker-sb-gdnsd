#!/usr/bin/env sh

set -e

docker-gdnsd-update.sh

gdnsdctl reload-zones
