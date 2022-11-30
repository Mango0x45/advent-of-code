Advent of Code
==============

This is a repository containing my solutions to the [Advent of Code][1], a
series of programming challenges released daily from the 1st to 25th of December
every year.  All sorts of languages are used in this repo.  You’ll mostly find
Awk and Python, but also a lot of other languages like C and Shell Script, and
even more “obscure” ones like Flex (a C lexer/scanner generator if you didn’t
know) or BC (an arbitrary precision calculator).

The repo should be simply to navigate, just select the folder of the
corresponding year and then the folder of the corresponding day.  Each days
folder should have a file called “input” with the input data and either two
files called “puzzle-1.ext” and “puzzle-2.ext” or one file called “puzzles.ext”.
In the latter case, there should be a Makefile you can run to build the two
individual programs or scripts to run each part seperately.  It’s rare but you
might also see both, in this case just run the “puzzles.ext” file as it’s
required to get the “puzzle-1.ext” and “puzzle-2.ext” files to actually run
properly.

[1]: https://adventofcode.com


Running Code
------------

Some of the solutions in this repo make use of `libaoc`.  In order to run these
solutions you need to add the directory of the library to the `PYTHONPATH`
environment variable.  In other words, instead of doing this:

```console
$ ./puzzle-1.py
```

You must do this:

```console
$ PYTHONPATH=../../ ./puzzle-1.py
```
