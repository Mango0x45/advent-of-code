#!/usr/bin/env -S awk -f

BEGIN { RS = "" }
{
	split($0, chars, "")
	for (i = 1; i <= length; i++) {
		if (chars[i] != "\n")
			answers[chars[i]] = 1
	}

	sum += length(answers)
	delete answers
}
END   { print sum }
