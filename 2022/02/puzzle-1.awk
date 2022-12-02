#!/usr/bin/awk -f

/X/ { s += 1 }
/Y/ { s += 2 }
/Z/ { s += 3 }

/A X|B Y|C Z/ { s += 3 }
/A Y|B Z|C X/ { s += 6 }

END { print s }
