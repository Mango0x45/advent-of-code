#!/usr/bin/awk -f

/[0-9]+/ { acc += $1 }
!/./     { if (acc > max) max = acc; acc = 0 }
END      { print max }
