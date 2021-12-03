#!/usr/bin/env sh

trap 'rm -f xa[ab]' EXIT
mid=$((`tr -d '\n' <input | wc -c` / 2))
sed 's/./&\n/g; s/\n$//' input | split -l $mid
paste xa[ab] | awk '$1 == $2 { s += $1 + $2 } END { print s }'
