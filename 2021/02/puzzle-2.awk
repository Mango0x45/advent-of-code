#!/usr/bin/env -S awk -f

/forward/ { hor += $2; ver += aim * $2 }
/up/      { aim -= $2 }
/down/    { aim += $2 }
END       { print hor * ver }
