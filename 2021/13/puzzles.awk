#!/usr/bin/env -S awk -f

BEGIN           { FS = ",|=" }
/[0-9]+,[0-9]+/ { grid[$2][$1] = 1 }

# START PART 1
flag == 1 { next }
# END PART 1

/x/ {
	for (y in grid) {
		for (x in grid[y]) {
			if (x * 1 > $2) {
				delete grid[y][x]
				grid[y][$2 - (x - $2)] = 1
			}
		}
	}
	# START PART 1
	flag = 1
	# END PART 1
}

/y/ {
	for (y in grid) {
		if (y * 1 > $2) {
			for (x in grid[y]) {
				delete grid[y][x]
				grid[$2 - (y - $2)][x] = 1
			}
		}
	}
	# START PART 1
	flag = 1
	# END PART 1
}

END {
	# START PART 1
	for (y in grid) {
		for (x in grid[y])
			acc += grid[y][x]
	}
	print acc
	# END PART 1 START PART 2
	for (y = 0; y < 6; y++) {
		for (x = 0; x < 29; x++)
			printf grid[y][x] ? "█" : " "
		print ""
	}
	# END PART 2
}
