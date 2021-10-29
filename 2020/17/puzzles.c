#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* PART2 is defined for part 2, but not for part 1 */
#ifdef PART2
	#define MAXTIME 50
#else
	#define MAXTIME 1
#endif
#define MAXDEPTH  50
#define MAXHEIGHT 50
#define MAXWIDTH  50

char space[MAXTIME][MAXDEPTH][MAXHEIGHT][MAXWIDTH];
char temp[MAXTIME][MAXDEPTH][MAXHEIGHT][MAXWIDTH];

/* Check the cubes around the given coordinates and update the temp array accordingly */
static void
update_cube(unsigned int const t, unsigned int const i, unsigned int const j, unsigned int const k)
{
	unsigned int active = 0;

	for (int tme = t - 1; tme <= (int) t + 1; tme++) {
		if (tme < 0 || tme > MAXTIME - 1)
			continue;
		for (int dep = i - 1; dep <= (int) i + 1; dep++) {
			if (dep < 0 || dep > MAXDEPTH - 1)
				continue;
			for (int hgt = j - 1; hgt <= (int) j + 1; hgt++) {
				if (hgt < 0 || hgt > MAXHEIGHT - 1)
					continue;
				for (int wid = k - 1; wid <= (int) k + 1; wid++) {
					if (wid < 0 || wid > MAXWIDTH - 1
					    || (tme == (int) t && dep == (int) i && hgt == (int) j
					        && wid == (int) k))
						continue;

					if (space[tme][dep][hgt][wid] == '#')
						active++;
				}
			}
		}
	}

	if (space[t][i][j][k] == '#' && (active == 2 || active == 3))
		temp[t][i][j][k] = '#';
	else if (space[t][i][j][k] == '.' && active == 3)
		temp[t][i][j][k] = '#';
	else
		temp[t][i][j][k] = '.';
}

int
main(void)
{
	/* Initialze space */
	memset(space, '.', MAXTIME * MAXDEPTH * MAXHEIGHT * MAXWIDTH);

	/* Read input */
	FILE *fpt = fopen("input", "r");
	char c;
	unsigned int t, i, j, k;

	j = k = 0;
	while ((c = fgetc(fpt)) != EOF) {
		if (c == '\n') {
			j++;
			k = 0;
		}
		else {
			space[MAXTIME / 2][MAXDEPTH / 2][j + MAXHEIGHT / 2][k + MAXWIDTH / 2] = c;
			k++;
		}
	}

	/* Do the boot cycles */
	for (int cycle = 0; cycle < 6; cycle++) {
		for (t = 0; t < MAXTIME; t++)
			for (i = 0; i < MAXDEPTH; i++)
				for (j = 0; j < MAXHEIGHT; j++)
					for (k = 0; k < MAXWIDTH; k++)
						update_cube(t, i, j, k);

		/* Copy temp to space */
		for (t = 0; t < MAXTIME; t++)
			for (i = 0; i < MAXDEPTH; i++)
				for (j = 0; j < MAXHEIGHT; j++)
					for (k = 0; k < MAXWIDTH; k++)
						space[t][i][j][k] = temp[t][i][j][k];
	}

	/* Count the active cubes */
	unsigned int count = 0;
	for (t = 0; t < MAXTIME; t++)
		for (i = 0; i < MAXDEPTH; i++)
			for (j = 0; j < MAXHEIGHT; j++)
				for (k = 0; k < MAXWIDTH; k++)
					if (space[t][i][j][k] == '#')
						count++;

	printf("%u\n", count);
	return EXIT_SUCCESS;
}
