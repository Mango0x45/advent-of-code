#!/usr/bin/awk -f

{ x += $1 }
END { print x }
