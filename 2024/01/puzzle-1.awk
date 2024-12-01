#!/usr/bin/awk -f

function abs(n) {
	return n < 0 ? -n : n
}

{
	xs[++i] = $1
	ys[i]   = $2
}

END {
	asort(xs)
	asort(ys)
	for (i in xs)
		d += abs(xs[i] - ys[i])
	print d
}