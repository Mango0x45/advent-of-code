#!/usr/bin/awk -f

{ xs[NR] = $1 }

END {
	for (;;) {
		for (i = 1; i <= length(xs); i++) {
			if (ys[x += xs[i]]++) {
				print x
				exit
			}
		}
	}
}
