#!/usr/bin/env -S awk -f

{
	for (i = 1; i <= NF; i++) {
		for (j = 1; j <= NF; j++) {
			if (i != j && $i % $j == 0) {
				acc += $i / $j
				next
			}
		}
	}
}

END { print acc }
