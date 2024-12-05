#!/usr/bin/awk -f

BEGIN { FS = "[|,]" }

/\|/ { rules[$1][$2] = 1 }
/,/ {
	delete seen
	for (i = 1; i <= NF; i++) {
		for (j in seen) {
			if (j in rules[$i])
				next
		}
		seen[$i] = 1
	}
	mid += $(i / 2)
}

END { print mid }