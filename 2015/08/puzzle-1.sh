#!/bin/sh

X=$(tr -d '\n' <input | wc -c)
Y=$(sed 's/\(^"\|"$\)//g; s/\\x[a-f0-9]\{2\}/./g; s/\\[\\"]/./g' input \
	| tr -d '\n'                                                   \
	| wc -c)
expr $X - $Y
