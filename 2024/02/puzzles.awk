#!/usr/bin/gawk -f

function sign(x)
{
	return x < 0 ? -1 : +1
}

function abs(x)
{
	return x < 0 ? -x : x
}

function check(skip,    xs, s, i, j, d, D)
{
	for (i = 1; i <= NF; i++) {
		if (i != skip)
			xs[++j] = $i
	}
	s = sign(xs[1] - xs[2])
	for (i = 2; i <= length(xs); i++) {
		d = xs[i - 1] - xs[i]
		D = abs(d)
		if (sign(d) != s || D < 1 || D > 3)
			return 0
	}
	return 1
}

# START PART 1
{ n += check() }
# END PART 1 START PART 2
!check() {
	for (i = 1; i <= NF; i++) {
		if (check(i))
			break
	}
	if (i > NF)
		next
}
{ n++ }
# END PART 2

END { print n }