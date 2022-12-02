#!/usr/bin/gawk -f

function abs(n) { return n < 0 ? -n : n }

function move(n) {
	# START PART 1
	d == 0 ? y += n : \
	d == 1 ? x += n : \
	d == 2 ? y -= n : \
	         x -= n
	# END PART 1 START PART 2
	for (i = 1; i <= n; i++) {
		d == 0 ? y++ : \
		d == 1 ? x++ : \
		d == 2 ? y-- : \
			 x--
		if (map[x, y]++)
			exit
	}
	# END PART 2
}

BEGIN { RS = ", "; FPAT = "[LR]|[0-9]+" }
/L/   { if (--d == -1) d = 3 }
/R/   { if (++d == +4) d = 0 }
      { move($2) }
END   { print abs(x) + abs(y) }
