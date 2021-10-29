#!/usr/bin/env sh

# I use bc-gh(1), but it's just Gavin Howards implementation of bc(1)

sed -e 's|[^0-9]*\([0-9]*\)[^0-9]*\([0-9]*\)[^0-9]*\([0-9]*\).*|x[y++] = calc(\1, \2, \3)|' \
    -e '$amax(x[], y)' input \
	| bc-gh -q puzzle-1.bc

sed -e 's|[^0-9]*\([0-9]*\)[^0-9]*\([0-9]*\)[^0-9]*\([0-9]*\).*|speed[n] = \1; time[n] = \2; rest[n++] = \3|' \
    -e '$acalc(speed[], time[], rest[], n)' input \
	| bc-gh -q puzzle-2.bc
