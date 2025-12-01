#!/usr/bin/awk -f

function mod(n, m)
{
	return ((n % m) + m) % m
}

BEGIN { dial = 50 }

{ n = substr($0, 2) }

/^L/ {
	sign = -1
	acc += int(n / 100) + (n%100 >= dial && dial != 0)
}
/^R/ {
	sign = +1
	acc += int((dial + n) / 100)
}

{ dial = mod(dial + n*sign, 100) }

END { print acc }
