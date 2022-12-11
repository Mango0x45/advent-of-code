#!/usr/bin/awk -f

BEGIN { x = 1 }

{ if ((++c - 20) % 40 == 0) s += c * x }
/addx/ { if ((++c - 20) % 40 == 0) s += c * x; x += $2 }

END { print s }
