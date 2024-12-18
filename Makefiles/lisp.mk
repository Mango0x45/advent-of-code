.POSIX:

all:
	sed -e '/START PART 2/,/END PART 2/d'                                       \
		-e '1a(defconstant +puzzle-part+ 1)'                                    \
		puzzles.lisp >puzzle-1.lisp
	sed -e '/START PART 1/,/END PART 1/d'                                       \
		-e '1a(defconstant +puzzle-part+ 2)'                                    \
		puzzles.lisp >puzzle-2.lisp
	chmod +x puzzle-[12].lisp

clean:
	rm -f puzzle-[12].lisp