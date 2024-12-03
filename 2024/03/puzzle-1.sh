#!/bin/sh

grep -Eo 'mul\([0-9]+,[0-9]+\)' input \
| awk 'BEGIN { FPAT = "[0-9]+" }
             { x += $1 * $2 }
       END   { print x }
'