#!/usr/bin/env -S awk -f

/forward/ { hor += $2 }
/up/      { ver -= $2 }
/down/    { ver += $2 }
END       { print hor * ver }
