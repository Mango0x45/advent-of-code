#!/usr/bin/gawk -f

function npaths(src, dst,    n, i)
{
	if (src == dst)
		return 1;
	for (i in paths[src])
		n += npaths(paths[src][i], dst)
	return n
}

BEGIN { FS = ":? " }

{
	for (i = 2; i <= NF; i++)
		paths[$1][i - 1] = $i
}

END { print npaths("you", "out") }
