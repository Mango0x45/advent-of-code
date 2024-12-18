#!/usr/bin/awk -f

function norbits(o)
{
	if (o in memo)
		return memo[o]
	return memo[o] = 1 + norbits(orbits[o])
}

BEGIN {
	FS = ")"
	memo["COM"] = 0
}

{ orbits[$2] = $1 }

END {
	for (o in orbits)
		n += norbits(o)
	print n
}