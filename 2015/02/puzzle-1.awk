#!/usr/bin/env -S awk -f

function min(a, b, c)
{
	if (a <= b && a <= c)
		return a
	if (b <= a && b <= c)
		return b
	return c
}

BEGIN { FS = "x" }
{
	x = $1 * $2
	y = $2 * $3
	z = $1 * $3

	sum += (2 * x) + (2 * y) + (2 * z) + min(x, y, z)
}
END   { print sum }
