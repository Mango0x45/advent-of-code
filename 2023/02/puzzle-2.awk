#!/usr/bin/awk -f

BEGIN {
	FS = "[;:] "
}

{
	r = 0; g = 0; b = 0

	for (i = 2; i <= NF; i++) {
		split($i, xs, /, /)
		for (j in xs) {
			split(xs[j], ys, / /)
			n = ys[1]
			c = ys[2]

			if (c == "red" && n > r)
				r = n
			else if (c == "green" && n > g)
				g = n
			else if (c == "blue" && n > b)
				b = n
		}
	}

	sum += r * g * b
}

END {
	print sum
}
