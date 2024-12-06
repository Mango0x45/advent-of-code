.POSIX:

CC = cc
CFLAGS =                                                                        \
	-Wall -Wextra -Wpedantic -Werror                                            \
	-march=native -mtune=native -O3 -flto                                       \
	-pipe

ALL = ${CC} ${CFLAGS} ${CPPFLAGS} ${LDLIBS}

all:
	if [ -f puzzles.c ];                                                        \
	then                                                                        \
		${ALL} -DPART1=1 -o puzzle-1 puzzles.c;                                 \
		${ALL} -DPART2=1 -o puzzle-2 puzzles.c;                                 \
	fi
	if [ -f puzzle-1.c ]; then ${ALL} -o puzzle-1 puzzle-1.c; fi
	if [ -f puzzle-2.c ]; then ${ALL} -o puzzle-2 puzzle-2.c; fi

clean:
	rm -f puzzle-[12]