#!/usr/bin/env -S awk -f

length == 0 {
	valid = 1
	for (i in fields) {
		if (fields[i] == "")
			valid = 0
	}

	if (valid)
		count++

	fields["byr"] = ""
	fields["iyr"] = ""
	fields["eyr"] = ""
	fields["hgt"] = ""
	fields["hcl"] = ""
	fields["ecl"] = ""
	fields["pid"] = ""
}

{
	for (i = 1; i <= NF; i++) {
		split($i, data, ":")
		fields[data[1]] = data[2]
	}
}

# Why do I need to subtract one? This code is so old I can't remember
END { print count - 1 }
