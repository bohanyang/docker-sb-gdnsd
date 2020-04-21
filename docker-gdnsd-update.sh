#!/usr/bin/env sh

set -e

test_exists_one()
{
  test -e "$1"
}

destdir="/etc/gdnsd"

# First Start: "/etc/gdnsd"
# Subsequent Updates: "/usr/src/docker-gdnsd/v0000000000000000000"
currdir="$(readlink -f $destdir)"

workdir="/usr/src/docker-gdnsd"
confdir="$workdir/conf"
defaults="$workdir/defaults"

# First Start: "/usr/src/docker-gdnsd/v0000000000000000000"
# Subsequent Updates: "/usr/src/docker-gdnsd/v1111111111111111111"
nextdir="$workdir/v$(date +%s%N)"

rm -rf "$nextdir"
mkdir "$nextdir"

mkdir -p "$confdir"
cp -R "$defaults/"* "$nextdir"

if test_exists_one "$confdir/"*; then
  cp -R "$confdir/"* "$nextdir"
fi

ln -sfn "$nextdir" "$destdir"

if gdnsd checkconf; then
  if [ "$currdir" != "$destdir" ]; then
    rm -rf "$currdir"
  fi
else
  if [ "$currdir" != "$destdir" ]; then
    ln -sfn "$currdir" "$destdir"
  fi
  rm -rf "$nextdir"
  exit 1
fi
