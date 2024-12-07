#!/usr/bin/gawk -f

function eval(i, acc)
{
	if (acc > $1)
		return 0
	if (i == NF + 1)
		return acc == $1
# START PART 1
	return eval(i + 1, acc * $i) || eval(i + 1, acc + $i)
# END PART 1 START PART 2
	return eval(i + 1, (acc $i) + 0) || eval(i + 1, acc * $i) ||
		eval(i + 1, acc + $i)
# END PART 2
}

BEGIN       { FS = ":? " }
eval(3, $2) { n += $1 }
END         { print n }