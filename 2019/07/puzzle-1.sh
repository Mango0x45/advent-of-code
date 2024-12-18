#!/bin/sh

python -c '
import itertools
for p in itertools.permutations([0, 1, 2, 3, 4]):
	print(*p)
' | while read a b c d e
do
	  ./machine.lisp $a 0                       \
	| ./machine.lisp $b                         \
	| ./machine.lisp $c                         \
	| ./machine.lisp $d                         \
	| ./machine.lisp $e
done | sort -nr | head -n1