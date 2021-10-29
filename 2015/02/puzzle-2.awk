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
	x = $1 + $1 + $2 + $2
	y = $2 + $2 + $3 + $3
	z = $1 + $1 + $3 + $3

	sum += $1 * $2 * $3 + min(x, y, z)
}
END   { print sum }
