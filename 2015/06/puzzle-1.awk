#!/usr/bin/env -S awk -f

function setlights(val, toggle)
{
	for (i = from[1]; i <= to[1]; i++) {
		for (j = from[2]; j <= to[2]; j++)
			lights[i][j] = toggle ? (lights[i][j] ? 0 : 1) : val
	}
}

$1 == "toggle" { split($2, from, ","); split($4, to, ","); setlights(0, 1) }
$2 ~ /on|off/  { split($3, from, ","); split($5, to, ",") }
$2 == "on"     { setlights(1, 0) }
$2 == "off"    { setlights(0, 0) }
END            { for (i = 0; i <= 999; i++) for (j = 0; j <= 999; j++) count += lights[i][j]; print count }
