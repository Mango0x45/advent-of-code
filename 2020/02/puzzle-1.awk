#!/usr/bin/env -S awk -f

{
	split($1, bounds, "-")
	freq = gsub(substr($2, 1, 1), "&") - 1
	if (freq >= bounds[1] && freq <= bounds[2])
		count++
}

END { print count }
