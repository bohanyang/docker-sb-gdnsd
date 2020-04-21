#!/usr/bin/env sh

set -e

destdir="/etc/gdnsd"
workdir="/usr/src/docker-gdnsd"
defaults="$workdir/defaults"

mkdir -p "$workdir"
mv "$destdir" "$defaults"

docker-gdnsd-update.sh

exec "$@"
