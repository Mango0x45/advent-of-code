#!/usr/bin/env -S awk -f

function move(xi, yi)
{
	for (k = 0; k < j; k++) {
		if (xi)
			x += xi
		else
			y += yi

		spiral[y][x] = spiral[y][x - 1] + spiral[y][x + 1] + spiral[y + 1][x + 1] \
				+ spiral[y + 1][x] + spiral[y + 1][x - 1] + spiral[y - 1][x + 1] \
				+ spiral[y - 1][x] + spiral[y - 1][x - 1]
		if (spiral[y][x] > n)
			return spiral[y][x]
	}
	return 0
}

{ n = $1 }

END {
	spiral[0][0] = 1
	x = y = 0
	j = 1
	for (i = 1; 1; i++) {
		if (i % 2)
			if (r = move(j % 2 ? 1 : -1, 0))
				break
		else {
			if (r = move(0, j % 2 ? 1 : -1))
				break
			j++
		}
	}

	print r
}
