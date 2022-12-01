#!/usr/bin/awk -f

/[0-9]+/ { acc += $1 }
!/./ {
	if (acc > max[1]) {
		max[3] = max[2];
		max[2] = max[1];
		max[1] = acc;
	} else if (acc > max[2]) {
		max[3] = max[2];
		max[2] = acc;
	} else if (acc > max[3])
		max[3] = acc;
	acc = 0
}

END { print max[1] + max[2] + max[3] }
