.POSIX:

CC = cc
CFLAGS =                                                                        \
	-Wall -Wextra -Wpedantic -Werror                                            \
	 -march=native -mtune=native -O3 -flto                                      \
	 -pipe

ALL = ${CC} ${CFLAGS} ${CPPFLAGS} ${LDLIBS}

all:
	flex -f -DYY_NO_INPUT --nounput puzzles.l
	${ALL} -lfl -DPART1 -o puzzle-1 lex.yy.c
	${ALL} -lfl -DPART2 -o puzzle-2 lex.yy.c
	rm lex.yy.c

clean:
	rm -f puzzle-[12]