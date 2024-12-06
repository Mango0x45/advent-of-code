#include <sys/stat.h>

#include <err.h>
#include <errno.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define new(a, T) ((T *)alloc(a, sizeof(T), _Alignof(T), 1))
#define BETWEEN(lo, n, hi) ((lo) <= (n) && (n) <= (hi))

typedef struct {
	ptrdiff_t x, y;
} vec2_t;

typedef enum {
	U,
	R,
	D,
	L,
} dir_t;

#if PART2
typedef struct {
	char *beg, *end;
} arena_t;

typedef struct {
	dir_t  d;
	vec2_t p;
} dpos_t;

typedef struct gposset {
    struct gposset *child[4];
    dpos_t          key;
} gposset_t;
#endif

static char *readinput(FILE *stream, vec2_t *start, vec2_t *size);
static vec2_t move(vec2_t pos, dir_t d);

#if PART1
static void simulate(char *buf, vec2_t pos, vec2_t size);
#else                           /* PART 2 */
static size_t loopcnt(char *buf, vec2_t pos, vec2_t size);
static bool loops(char *buf, vec2_t pos, vec2_t size);
static uint64_t hash(dpos_t dp);
static bool ismember(gposset_t **m, dpos_t key, arena_t *perm);
static void *alloc(arena_t *a, ptrdiff_t size, ptrdiff_t align,
                   ptrdiff_t count);

static char MEM[1024 * 1024];   /* 1 MiB */
#endif

int
main(void)
{
	FILE *fp = fopen("input", "r");
	if (fp == NULL)
		err(EXIT_FAILURE, "fopen: input");

	vec2_t pos, size;
	char *buf = readinput(fp, &pos, &size);

#if PART1
	size_t n = 0;
	simulate(buf, pos, size);
	for (const char *p = buf; *p != 0; p++) {
		if (*p == 'X')
			n++;
	}
#else
	size_t n = loopcnt(buf, pos, size);
#endif
	printf("%zu\n", n);

	fclose(fp);
	return EXIT_SUCCESS;
}

char *
readinput(FILE *stream, vec2_t *start, vec2_t *size)
{
	struct stat sb;
	if (fstat(fileno_unlocked(stream), &sb) == -1)
		err(EXIT_FAILURE, "fstat: input");

	char *buf = malloc(sb.st_size + 1);
	if (buf == NULL)
		err(EXIT_FAILURE, "malloc");
	buf[sb.st_size] = 0;

	if (fread_unlocked(buf, 1, sb.st_size, stream) != (size_t)sb.st_size)
		err(EXIT_FAILURE, "fread: input");

	start->x = start->y = 0;
	for (const char *p = buf; *p != '^'; p++) {
		if (*p == '\n') {
			start->x = 0;
			start->y++;
		} else
			start->x++;
	}

	size->x = strchr(buf, '\n') - buf;
	size->y = (sb.st_size + 1) / (size->x + 1); /* Last line lacks newline */

	return buf;
}

#if PART1

void
simulate(char *buf, vec2_t pos, vec2_t size)
{
#define I(p) (p.y*(size.x + 1) + p.x)
	dir_t d = U;
	do {
		buf[I(pos)] = 'X';
		vec2_t np = move(pos, d);
		if (buf[I(np)] == '#') {
			d = (d + 1) % 4;
			pos = move(pos, d);
		} else
			pos = np;
	} while (BETWEEN(0, pos.x, size.x - 1)
	      && BETWEEN(0, pos.y, size.y - 1));
#undef I
}

#else                           /* PART 2 */

size_t
loopcnt(char *buf, vec2_t pos, vec2_t size)
{
	size_t n = 0;
	for (char *p = buf; *p != 0; p++) {
		if (*p == '.') {
			*p = '#';
			n += loops(buf, pos, size);
			*p = '.';
		}
	}
	return n;
}

bool
loops(char *buf, vec2_t pos, vec2_t size)
{
	dir_t d = U;
	gposset_t *set = NULL;
	arena_t perm = {MEM, MEM + sizeof(MEM)};

	do {
		if (ismember(&set, (dpos_t){d, pos}, &perm))
			return true;
		int i;
		for (i = 0; i < 4; i++) {
			vec2_t np = move(pos, d);
			if (buf[np.y*(size.x + 1) + np.x] != '#') {
				pos = np;
				break;
			}
			d = (d + 1) % 4;
		}
		if (i == 4)
			return true;
	} while (BETWEEN(0, pos.x, size.x - 1)
	      && BETWEEN(0, pos.y, size.y - 1));
	return false;
}

void *
alloc(arena_t *a, ptrdiff_t size, ptrdiff_t align, ptrdiff_t count)
{
	ptrdiff_t padding = -(uintptr_t)a->beg & (align - 1);
	ptrdiff_t available = a->end - a->beg - padding;
	if (available < 0 || count > available/size) {
		errno = ENOMEM;
		err(EXIT_FAILURE, "%s", __func__);
	}
	void *p = a->beg + padding;
	a->beg += padding + count*size;
	return memset(p, 0, count * size);
}

bool
ismember(gposset_t **m, dpos_t key, arena_t *perm)
{
	for (uint64_t h = hash(key); *m; h <<= 2) {
		dpos_t l = key, r = (*m)->key;
		if (l.d == r.d && l.p.x == r.p.x && l.p.y == r.p.y)
			return true;
		m = &(*m)->child[h >> 62];
	}
	*m = new(perm, gposset_t);
	(*m)->key = key;
	return false;
}

static uint64_t
_hash(uint64_t x)
{
    x = ((x >> 16) ^ x) * 0x45D9F3B;
    x = ((x >> 16) ^ x) * 0x45D9F3B;
    x = ((x >> 16) ^ x);
    return x;
}

uint64_t
hash(dpos_t dp)
{
	return _hash(dp.d) ^ _hash(dp.p.x) ^ _hash(dp.p.y);
}

#endif

vec2_t
move(vec2_t pos, dir_t d)
{
	static const vec2_t dirs[] = {
		[U] = {0, -1},
		[D] = {0, +1},
		[L] = {-1, 0},
		[R] = {+1, 0},
	};
	vec2_t np = dirs[d];
	return (vec2_t){
		.x = pos.x + np.x,
		.y = pos.y + np.y,
	};
}