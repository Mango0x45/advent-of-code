.POSIX:

CC     = cc
CFLAGS = -Wall -Wextra -Wpedantic -Werror      \
	 -march=native -mtune=native -O3 -flto \
	 -pipe

ALL    = ${CC} ${CFLAGS} ${CPPFLAGS} ${LDLIBS} ${LDFLAGS}

all:
	[ -f puzzles.c ] && {                         \
		${ALL} -DPART1 -o puzzle-1 puzzles.c; \
		${ALL} -DPART2 -o puzzle-2 puzzles.c; \
	}
	[ -f puzzle-1.c ] && ${ALL} -o puzzle-1 puzzle-1.c || true
	[ -f puzzle-2.c ] && ${ALL} -o puzzle-2 puzzle-2.c || true

clean:
	rm -f puzzle-[12]
