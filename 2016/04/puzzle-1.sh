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
		| awk "{ s = s \$2 } END { if (s == \"$cksum\") print $sid }"
done <input | awk '{ s += $0 } END { print s }'
