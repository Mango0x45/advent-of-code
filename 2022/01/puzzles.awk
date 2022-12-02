#!/usr/bin/gawk -f

BEGIN { RS = ""; FS = "\n" }
      { for (i = 1; i <= NF; i++) s[NR] += $i }
END   {
	asort(s)
	# START PART 1
	print s[NR]
	# END PART 1 START PART 2
	print s[NR] + s[NR - 1] + s[NR - 2]
	# END PART 2
}
