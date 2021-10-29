#!/usr/bin/env sh

X=$(sed 's/\("\|\\\)/\\&/g; s/^/../' input \
	| tr -d '\n' \
	| wc -c)
Y=$(tr -d '\n' <input | wc -c)
expr $X - $Y
