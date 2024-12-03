#!/bin/sh

grep -Eo "(mul\\([0-9]+,[0-9]+\\)|do(n't)?\(\))" input \
| awk 'BEGIN        { FPAT = "[0-9]+"; go = 1 }
       /do\(/       { go = 1 }
       /don/        { go = 0 }
       /mul/ && go  { x += $1 * $2 }
       END          { print x }
'