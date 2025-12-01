#!/usr/bin/awk -f

function mod(n, m)
{
	return ((n % m) + m) % m
}

BEGIN { dial = 50 }

/^L/ { sign = -1 }
/^R/ { sign = +1 }

{
	n = substr($0, 2)
	if ((dial = mod(dial + n*sign, 100)) == 0)
		acc++
}

END { print acc }
