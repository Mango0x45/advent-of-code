#!/bin/sh

# This is slow, but it’s fun!  That’s what counts!

while IFS='[]' read -r line cksum; do
	sid=`echo $line | grep -o '[0-9]*'`
	echo $line \
		| tr -d -- '-0-9\n' \
		| sed 's/./&\n/g'   \
		| sort              \
		| uniq -c           \
		| sort -k1nr        \
		| head -n5          \
# START PART 1
		| awk "{ s = s \$2 } END { if (s == \"$cksum\") print $sid }"
done <input | awk '{ s += $0 } END { print s }'
# END PART 1 START PART 2
		| awk "{ s = s \$2 } END { if (s == \"$cksum\") print \"$line\" }"
done <input | \
	while read -r line; do
		for i in `seq 25`; do
			echo $line | tr $(printf %${i}s | tr ' ' '.')\a-z a-za-z
		done
		# The call to head(1) allows us to exit the moment we find the
		# first match.
	done | grep north | grep -o '[0-9]*' | head -n1
# END PART 2
