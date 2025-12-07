#!/usr/bin/awk -f

NR == 1 {
	for (i = 1; i <= NF; i++)
		xs[i, 2] = 1
}

!/[+*]/ {
	for (i = 1; i <= NF; i++) {
		xs[i, 1] += $i
		xs[i, 2] *= $i
	}
}

/[+*]/ {
	for (i = 1; i <= NF; i++)
		total += xs[i, $i == "+" ? 1 : 2]
}

END { print total }
