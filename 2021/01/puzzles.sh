#!/usr/bin/env sh

paste -s input | awk '{ for (i = 1; i < NF; i++) c += $i < $(i + DELTA) } END { print c }'
