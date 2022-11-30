#!/usr/bin/awk -f

function min(a, b, c) {
	if (a <= b && a <= c)
		return a
	if (b <= a && b <= c)
		return b
	return c
}

BEGIN { FS = "x" }
{
	# START PART 1
	x = $1 * $2
	y = $2 * $3
	z = $1 * $3

	sum += (2 * x) + (2 * y) + (2 * z) + min(x, y, z)
	# END PART 1 START PART 2
	x = $1 + $1 + $2 + $2
	y = $2 + $2 + $3 + $3
	z = $1 + $1 + $3 + $3

	sum += $1 * $2 * $3 + min(x, y, z)
	# END PART 2
}
END   { print sum }
