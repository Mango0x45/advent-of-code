#!/usr/bin/awk -f

BEGIN {
	FS = "[;:] "

	r = 12
	g = 13
	b = 14
}

{
	for (i = 2; i <= NF; i++) {
		split($i, xs, /, /)
		for (j in xs) {
			split(xs[j], ys, / /)
			n = ys[1]
			c = ys[2]

			if (c == "red" && n > r || c == "green" && n > g ||
					c == "blue" && n > b)
				next
		}
	}

	sub(/Game /, "", $1)
	sum += $1
}

END {
	print sum
}
