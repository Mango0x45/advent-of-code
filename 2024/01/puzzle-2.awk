#!/usr/bin/awk -f

{
	xs[NR] = $1
	ys[$2]++
}

END {
	for (i in xs)
		d += xs[i] * ys[xs[i]]
	print d
}