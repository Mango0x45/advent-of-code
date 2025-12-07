#!/usr/bin/awk -f

BEGIN { FS = "-" }

NF == 2 {
	xs[NR, 1] = $1
	xs[NR, 2] = $2
}

NF == 1 {
	for (i = 1; i <= length(xs) / 2; i++) {
		if ($1 >= xs[i, 1] && $1 <= xs[i, 2]) {
			cnt++
			break
		}
	}
}

END { print cnt }
