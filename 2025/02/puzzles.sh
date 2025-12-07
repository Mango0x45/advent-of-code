#!/bin/sh

# START PART 1
readonly REGEXP='^([0-9]+)\1$'
# END PART 1 START PART 2
readonly REGEXP='^([0-9]+)\1+$'
# END PART 2

tr ',' '\n' <input | while IFS=- read -r x y
do
	seq -f %1.0f $x $y
done | grep -E "$REGEXP" | awk '{ n += $1 } END { print n }'
