#!/bin/sh

set -e

ROOT="`pwd`"

trap "rm -rf \"$ROOT/run\"" EXIT HUP INT TERM
mkdir run; cd run

while read -r line; do
	case "$line" in
	'$ cd /') cd "$ROOT/run"       ;;
	'$ cd'*)  cd "${line#\$ cd }"  ;;
	dir*)     mkdir "${line#dir }" ;;
	[0-9]*)   touch "${line% *}"   ;;
	esac
done <"$ROOT/input"

cd "$ROOT/run"
find . -type d | while read -r dir; do
	{ echo -n 0; find "$dir" -type f -printf ' + %f'; } | xargs expr
# START PART 1
done | awk '$0 <= 100000 { s += $0 } END { print s }'
# END PART 1 START PART 2
done | sort -nr | awk '
NR == 1 { n = 30000000 - (70000000 - $0); s = $0 }
        { if ($0 < s && $0 >= n) s = $0 }
END     { print s }
'
# END PART 2
