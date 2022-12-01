#!/usr/bin/gawk -f

/[0-9]+/ { acc += $1 }
!/./     { max[++i] = acc; acc = 0 }
END      { asort(max); print max[i] + max[i - 1] + max[i - 2] }
