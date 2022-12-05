#!/usr/bin/gawk -f

BEGIN {
	FIELDWIDTHS = "1:1 3:1 3:1 3:1 3:1 3:1 3:1 3:1 3:1"
	while (data[n] !~ /[0-9]/)
		getline data[++n]

	j = 1
	for (i = n - 1; i > 0; i--) {
		$0 = data[i]
		for (k = 1; k <= NF; k++) {
			if ($k != " ")
				s[k][j] = $k
		}
		j++
	}

	getline  # Ignore blank line
	FPAT = "[0-9]+"
}

{
	# START PART 2
	l = length(s[$2])
	# END PART 2

	for (i = 1; i <= $1; i++) {
		# START PART 1
		s[$3][length(s[$3]) + 1] = s[$2][length(s[$2])]
		delete s[$2][length(s[$2])]
		# END PART 1 START PART 2
		s[$3][length(s[$3]) + 1] = s[$2][l - $1 + i]
		delete s[$2][l - $1 + i]
		# END PART 2
	}
}

END {
	for (i = 1; i <= 9; i++)
		printf s[i][length(s[i])]
	print ""
}
