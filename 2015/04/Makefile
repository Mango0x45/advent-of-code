all:
	${CC} ${CFLAGS} -lmd -DINPUT=\"$$(cat input)\" -o puzzle-1 puzzles.c
	${CC} ${CFLAGS} -lmd -DINPUT=\"$$(cat input)\" -DPART2 -o puzzle-2 puzzles.c

.PHONY: clean
clean:
	rm -f puzzle-[12]
