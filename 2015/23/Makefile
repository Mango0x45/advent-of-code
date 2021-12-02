all:
	flex -f -DYY_NO_INPUT --nounput puzzles.l
	${CC} ${CFLAGS} -lfl -DPROGLEN=`wc -l <input` -o puzzle-1 lex.yy.c
	${CC} ${CFLAGS} -lfl -DPROGLEN=`wc -l <input` -DPART2 -o puzzle-2 lex.yy.c
	rm lex.yy.c

.PHONY: clean
clean:
	rm -f puzzle-[12]
