#!/usr/bin/gawk -f

function rangecmp(i1, v1, i2, v2)
{
	return v1[1] - v2[1]
}

function max(x, y)
{
	return x > y ? x : y
}

BEGIN { FS = "-" }

NF == 2 {
	xs[NR][1] = $1
	xs[NR][2] = $2
}

END {
	asort(xs, xs, "rangecmp")
	for (i in xs) {
		if (xs[i][2] <= m)
			continue
		cnt += xs[i][2] - max(xs[i][1], m)
		if (xs[i][1] > m)
			cnt++
		m = xs[i][2]
	}
	print cnt
}
