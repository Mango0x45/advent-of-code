#!/usr/bin/awk -f

function abs(n) {
	return n < 0 ? -n : n
}

{
	xs[NR] = $1
	ys[NR] = $2
}

END {
	asort(xs)
	asort(ys)
	for (i in xs)
		d += abs(xs[i] - ys[i])
	print d
}