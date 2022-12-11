#!/usr/bin/awk -f

BEGIN { x = 1 }

{
	for (i = 0; i < ($1 == "addx" ? 2 : 1); i++) {
		p = (++c % 40) - 1
		if (p == -1)
			p = 39
		printf (p == x - 1 || p == x || p == x + 1) ? "█" : " "
		if (p == 39)
			print ""
	}
}
/addx/ { x += $2 }
