#!/usr/bin/env sh

# I could not figure this out on my own, but god bless this guy for doing the math:
# https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/cy4etju/

# Some people has inputs that could be solved by just going in reverse trivially, my input did not
# work

sed -n '
$ {
	s/^/0/
	s/\(Ar\|Rn\)//g
	s/\(Y\|$\)/-1/g
	s/[A-Z][a-z]*/+1/g
	p
}' input | bc
