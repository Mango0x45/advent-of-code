.POSIX:

all:
	f() {                                                                       \
		n=$$(expr \( $$1 - 1 \| 2 \));                                          \
		sed "/START PART $$n/,/END PART $$n/d" puzzles.go >tmp$$1.go;           \
		go build tmp$$1.go;                                                     \
		mv tmp$$1 puzzle-$$1;                                                   \
		rm -f tmp$$1;                                                           \
	};                                                                          \
	f 1;                                                                        \
	f 2;

clean:
	rm -f puzzle-[12]