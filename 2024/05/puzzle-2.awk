#!/usr/bin/gawk -f

function sort_page_numbers(i1, v1, i2, v2)
{
	if (v1 in rules[v2])
		return +1
	if (v2 in rules[v1])
		return -1
	return 0
}

BEGIN { FS = "[|,]" }

/\|/ { rules[$1][$2] = 1 }
/,/ {
	delete seen
	badent = 0

	for (i = 1; i <= NF; i++) {
		for (j in seen) {
			if (j in rules[$i])
				badent = 1
		}
		seen[$i] = 1
	}
	if (!badent)
		next

	split($0, xs)
	asort(xs, xs, "sort_page_numbers")
	mid += xs[(NF + 1) / 2]
}

END { print mid }