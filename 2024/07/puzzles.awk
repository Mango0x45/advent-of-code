#!/usr/bin/gawk -f

@load "intdiv"

# START PART 2
function pow(x, e,    n)
{
	for (n = 1; e--; n *= x)
		;
	return n
}
# END PART 2

function eval(i, acc,    a)
{
	if (acc <= 0)
		return 0
	if (i == 2)
		return acc == $2

# START PART 2
	intdiv(acc, pow(10, length($i)), a)
	if (a["remainder"] == $i && eval(i - 1, a["quotient"]))
		return 1
# END PART 2

	intdiv(acc, $i, a)
	if (a["remainder"] == 0 && eval(i - 1, a["quotient"]))
		return 1

	return eval(i - 1, acc - $i)
}

BEGIN        { FS = ":? " }
eval(NF, $1) { n += $1 }
END          { print n }