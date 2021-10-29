#!/usr/bin/env -S awk -f

BEGIN {
	RS = ""
	FS = "\n"
}

{
	for (i = 1; i <= NF; i++) {
		len = split($i, answers, "")
		for (j = 1; j <= len; j++)
			count[answers[j]]++
	}

	for (i in count) {
		if (count[i] == NF)
			sum++
	}

	delete count
}

END { print sum }
