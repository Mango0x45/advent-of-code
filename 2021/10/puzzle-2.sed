:top
s/()//
s/\[\]//
s/{}//
s/<>//
t top

/[])}>]/d

:loop
s/\([(\[{<]*\)($/s = s * 5 + 1;\1/
s/\([(\[{<]*\)\[$/s = s * 5 + 2;\1/
s/\([(\[{<]*\){$/s = s * 5 + 3;\1/
s/\([(\[{<]*\)<$/s = s * 5 + 4;\1/
t loop

is = 0;
as
