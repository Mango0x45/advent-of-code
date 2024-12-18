#!/usr/bin/awk -f

function trace_to_com(xs, o)
{
	if (o == "COM")
		return
	o = orbits[o]
	xs[length(xs) + 1] = o
	trace_to_com(xs, o)
}

BEGIN { FS = ")" }

{ orbits[$2] = $1 }

END {
	# Declare ‘xs’ and ‘ys’ as arrays
	xs[0]; delete xs
	ys[0]; delete ys

	trace_to_com(xs, "YOU")
	trace_to_com(ys, "SAN")

	for (i = 1; i <= length(xs); i++) {
		for (j = 1; j <= length(ys); j++) {
			if (xs[i] == ys[j]) {
				print i + j - 2
				exit
			}
		}
	}
}