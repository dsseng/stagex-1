#!/bin/sh
set -eu

date="$(date '+%D %T')"

rm -rf "out/$1"
mkdir -p "out/$1"
crane pull --format oci ghcr.io/siderolabs/stagex/$2 out/$1

find out -type f -exec touch -d "$date" {} +
