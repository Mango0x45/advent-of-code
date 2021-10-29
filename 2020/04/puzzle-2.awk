#!/usr/bin/env -S awk -f

function between(x, l, h)
{
	return (x >= l) && (x <= h)
}

BEGIN {
	eyecolor[1] = "amb"
	eyecolor[2] = "blu"
	eyecolor[3] = "brn"
	eyecolor[4] = "gry"
	eyecolor[5] = "grn"
	eyecolor[6] = "hzl"
	eyecolor[7] = "oth"
}

length == 0 {
	valid = 1

	if (!(between(fields["byr"], 1920, 2002) && between(fields["iyr"], 2010, 2020) &&
			between(fields["eyr"], 2020, 2030) && length(fields["pid"]) == 9))
		valid = 0
	else {
		# Test eyecolor
		valid = 0
		for (i in eyecolor) {
			if (fields["ecl"] == eyecolor[i]) {
				valid = 1
				break
			}
		}

		# Test height
		split(fields["hgt"], height, "[^0-9]")
		if ((fields["hgt"] ~ "cm" && !between(height[1], 150, 193)) ||
				(fields["hgt"] ~ "in" && !between(height[1], 59, 76)) ||
				(fields["hgt"] !~ "cm|in"))
			valid = 0

		# Test haircolor
		if (fields["hcl"] !~ "^#[0-9a-f]{6}")
			valid = 0
	}

	if (valid == 1)
		count++

	fields["byr"] = ""
	fields["iyr"] = ""
	fields["eyr"] = ""
	fields["hgt"] = ""
	fields["hcl"] = ""
	fields["ecl"] = ""
	fields["pid"] = ""
	next
}

# Non-blank lines
{
	for (i = 1; i <= NF; i++) {
		split($i, data, ":")
		fields[data[1]] = data[2]
	}
}

END { print count }
