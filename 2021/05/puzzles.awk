#!/usr/bin/env -S awk -f

BEGIN { FS = ",| -> " }

$1 == $3 && $2 <= $4 { for (i = $2; i <= $4; i++) grid[i][$1]++; next }
$1 == $3             { for (i = $4; i <= $2; i++) grid[i][$1]++; next }
$2 == $4 && $1 <= $3 { for (i = $1; i <= $3; i++) grid[$2][i]++; next }
$2 == $4             { for (i = $3; i <= $1; i++) grid[$2][i]++; next }

# START PART 2
$1 <= $3 && $2 <= $4 { while (!($1 > $3)) { grid[$2][$1]++; $1++; $2++ } next }
$1 <= $3             { while (!($1 > $3)) { grid[$2][$1]++; $1++; $2-- } next }
$2 <= $4             { while (!($1 < $3)) { grid[$2][$1]++; $1--; $2++ } next }
                     { while (!($1 < $3)) { grid[$2][$1]++; $1--; $2-- } next }
# END PART 2

END {
	for (i = 0; i < 1000; i++) {
		for (j = 0; j < 1000; j++) {
			if (grid[i][j] > 1)
				acc++
		}
	}
	print acc
}
