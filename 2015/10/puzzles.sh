#!/usr/bin/env sh

output() {
	echo $in | tr -d '\n' | wc -c
}

in=$(cat input)
for i in $(seq 1 50); do
	in=$(echo "$in" | fold -w1 | uniq -c | tr -d '\n ')
	[ $i -eq 40 ] && output
done
output
