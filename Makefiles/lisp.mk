.POSIX:

all:
	sed '/START PART 2/,/END PART 2/d' puzzles.lisp >puzzle-1.lisp
	sed '/START PART 1/,/END PART 1/d' puzzles.lisp >puzzle-2.lisp
	chmod +x puzzle-[12].lisp

clean:
	rm -f puzzle-[12].lisp