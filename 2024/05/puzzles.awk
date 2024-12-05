#!/usr/bin/gawk -f

function record_valid(    seen)
{
	for (i = 1; i <= NF; i++) {
		for (j in seen) {
			if (j in rules[$i])
				return 0
		}
		seen[$i] = 1
	}
	return 1
}

function sort_page_numbers(i1, v1, i2, v2)
{
	if (v1 in rules[v2])
		return +1
	if (v2 in rules[v1])
		return -1
	return 0
}

BEGIN { FS = "[|,]" }
/\|/  { rules[$1][$2] = 1 }
END   { print mid }

# START PART 1
/,/ && record_valid() { mid += $(i / 2) }
# END PART 1 START PART 2
/,/ && !record_valid() {
	split($0, xs)
    asort(xs, xs, "sort_page_numbers")
	mid += xs[(NF + 1) / 2]
}
# END PART 2