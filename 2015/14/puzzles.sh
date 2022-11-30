#!/usr/bin/env sh

sed -E \
    -e 's|[^0-9]*([0-9]*)[^0-9]*([0-9]*)[^0-9]*([0-9]*).*|x[y++] = calc(\1, \2, \3)|' \
    -e '$amax(x[], y)' input \
	| bc -q puzzle-1.bc

sed -E \
    -e 's|[^0-9]*([0-9]*)[^0-9]*([0-9]*)[^0-9]*([0-9]*).*|speed[n] = \1; time[n] = \2; rest[n++] = \3|' \
    -e '$acalc(speed[], time[], rest[], n)' input \
	| bc -q puzzle-2.bc
