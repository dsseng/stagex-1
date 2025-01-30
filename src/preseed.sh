#!/bin/sh
set -eu

date="$(date '+%D %T')"

fetch(){
	line=${1?}
	local package=$(echo ${line} | sed 's/^[a-z0-9]\+ \(.*\)/\1/g');
	local hash=$(echo ${line} | sed 's/^\([a-z0-9]\+\) .*/\1/g');
	local ref=$(printf "stagex/%s@sha256:%s" "$package" "$hash");
	rm -rf "out/${package}"
	mkdir -p "out/${package}"
	crane pull --format oci ${ref} out/${package}
}

while read line; do
	fetch "${line}"
done < digests.txt

find out -type f -exec touch -d "$date" {} +
