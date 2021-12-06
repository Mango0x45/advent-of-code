all:
	${CC} ${CFLAGS} -DPROGLEN=`wc -l <input` -o puzzle-1 puzzles.c
	${CC} ${CFLAGS} -DPART2 -DPROGLEN=`wc -l <input` -o puzzle-2 puzzles.c

.PHONY: clean
clean:
	rm -f puzzle-[12]
