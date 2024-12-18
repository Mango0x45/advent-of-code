#!/bin/sh

mkfifo pipe
trap 'rm pipe' EXIT

python -c '
import itertools
for p in itertools.permutations([5, 6, 7, 8, 9]):
	print(*p)
' | while read a b c d e
do
	  ./machine.lisp $a 0 <pipe                 \
	| ./machine.lisp $b                         \
	| ./machine.lisp $c                         \
	| ./machine.lisp $d                         \
	| ./machine.lisp $e                         \
	| tee pipe                                  \
	| tail -n1
done | sort -nr | head -n1