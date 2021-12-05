#!/usr/bin/env -S awk -f

{
	min = max = $1
	for (i = 2; i <= NF; i++) {
		if ($i > max)
			max = $i
		else if ($i < min)
			min = $i
	}
	acc += max - min
}

END { print acc }
