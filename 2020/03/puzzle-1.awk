#!/usr/bin/env -S awk -f

BEGIN { x = 1 }
{
	len = split($0, obs, "")

	if (x > len)
		x -= len
	if (obs[x] == "#")
		count++

	x += 3
}
END  { print count }
