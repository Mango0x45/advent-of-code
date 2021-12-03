#!/usr/bin/env -S awk -f

BEGIN { FS = "" }

{
	for (i = 1; i <= NF; i++) {
		if ($i == "0")
			z[i]++
		else
			o[i]++
	}
}

END {
	for (i = 1; i <= NF; i++) {
		g = g (z[i] > o[i] ? "0" : "1")
		e = e (z[i] < o[i] ? "0" : "1")
	}
	(cmd = "echo 'ibase = 2;" g "*" e "' | bc") | getline out
	close(cmd)
	print out
}
