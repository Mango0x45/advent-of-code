#!/usr/bin/env sh

sort -n input | awk '
BEGIN  { o = t = 1 }
NR > 1 { if ($0 - prev == 1) o++; else if ($0 - prev == 3) t++; }
       { prev = $0 }
END    { print o * t }'
