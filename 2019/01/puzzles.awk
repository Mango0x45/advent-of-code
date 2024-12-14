#!/usr/bin/awk -f

function fuel(n)
{
	n = int(n / 3) - 2
	# START PART 1
	return n
	# END PART 1 START PART 2
	return n <= 0 ? 0 : n + fuel(n)
	# END PART 2
}

{ n += fuel($1) }
END { print n }