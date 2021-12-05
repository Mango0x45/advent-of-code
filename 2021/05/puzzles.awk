#!/usr/bin/env -S awk -f

BEGIN { FS = ",| -> " }

$1 == $3 && $2 <= $4 { while ($2 <= $4) grid[$2++][$1]++; next }
$1 == $3             { while ($4 <= $2) grid[$4++][$1]++; next }
$2 == $4 && $1 <= $3 { while ($1 <= $3) grid[$2][$1++]++; next }
$2 == $4             { while ($3 <= $1) grid[$2][$3++]++; next }

# START PART 2
$1 <= $3 && $2 <= $4 { while (!($1 > $3)) grid[$2++][$1++]++; next }
$1 <= $3             { while (!($1 > $3)) grid[$2--][$1++]++; next }
$2 <= $4             { while (!($1 < $3)) grid[$2++][$1--]++; next }
                     { while (!($1 < $3)) grid[$2--][$1--]++; next }
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
