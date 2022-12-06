#!/usr/bin/gawk -f

BEGIN {
	RS = "[a-z]"
	# START PART 1
	COUNT = 4
	# END PART 1 START PART 2
	COUNT = 14
	# END PART 2
}
NR > COUNT {
	for (i = 2; i <= length(a); i++)
		a[i - 1] = a[i]
	delete a[length(a)]
}
{ a[(NR == 1 ? 0 : length(a)) + 1] = RT }
NR > COUNT {
	for (i in a) {
		if (_a[a[i]]++ == 1) {
			delete _a
			next
		}
	}
	print NR
	exit
}
