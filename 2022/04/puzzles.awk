#!/usr/bin/awk -f

BEGIN { FS = "[,-]" }
# START PART 1
($1 <= $3 && $2 >= $4) || ($1 >= $3 && $2 <= $4) { c++ }
# END PART 1 START PART 2
($3 >= $1 && $3 <= $2) || ($4 >= $1 && $4 <= $2) ||
       ($1 >= $3 && $1 <= $4) || ($2 >= $3 && $2 <= $4) { c++ }
# END PART 2
END { print c }
