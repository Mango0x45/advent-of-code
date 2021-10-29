#include <err.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#define ROWCNT 98
#define ROWLEN 98

#ifdef PART2
	#define IS_SEAT(a, b)                                                                              \
		if (rows[a][b] == '.')                                                             \
		continue
	#define IS_OCC(a, b)                                                                               \
		if (rows[a][b] == '#')                                                             \
		adjecent++
#endif

bool changed;
char rows[ROWCNT][ROWLEN + 1];
char temp[ROWCNT][ROWLEN + 1];

/* Check and update a seat at the given index */
static void
check_seat(int const i, int const j)
{
	if (rows[i][j] == '.')
		return;

	int adjecent = 0;

#ifdef PART2
	/* Up */
	for (int h = i - 1; h >= 0; h--) {
		IS_SEAT(h, j);
		IS_OCC(h, j);
		break;
	}
	/* Down */
	for (int h = i + 1; h < ROWCNT; h++) {
		IS_SEAT(h, j);
		IS_OCC(h, j);
		break;
	}
	/* Left */
	for (int h = j - 1; h >= 0; h--) {
		IS_SEAT(i, h);
		IS_OCC(i, h);
		break;
	}
	/* Right */
	for (int h = j + 1; h < ROWLEN; h++) {
		IS_SEAT(i, h);
		IS_OCC(i, h);
		break;
	}
	/* Up-Left */
	for (int h = i - 1, k = j - 1; h >= 0 && k >= 0; h--, k--) {
		IS_SEAT(h, k);
		IS_OCC(h, k);
		break;
	}
	/* Up-Right */
	for (int h = i - 1, k = j + 1; h >= 0 && k < ROWLEN; h--, k++) {
		IS_SEAT(h, k);
		IS_OCC(h, k);
		break;
	}
	/* Down-Left */
	for (int h = i + 1, k = j - 1; h < ROWCNT && k >= 0; h++, k--) {
		IS_SEAT(h, k);
		IS_OCC(h, k);
		break;
	}
	/* Down-Right */
	for (int h = i + 1, k = j + 1; h < ROWCNT && k < ROWLEN; h++, k++) {
		IS_SEAT(h, k);
		IS_OCC(h, k);
		break;
	}
#else
	for (int h = i - 1; h <= i + 1; h++) {
		if (h < 0 || h > ROWCNT - 1)
			continue;
		for (int k = j - 1; k <= j + 1; k++) {
			if (k < 0 || k > ROWCNT - 1 || (h == i && k == j))
				continue;
			if (rows[h][k] == '#')
				adjecent++;
		}
	}
#endif
	/* Edit seats as needed */
	if (rows[i][j] == 'L' && adjecent == 0) {
		temp[i][j] = '#';
		changed = true;
#ifdef PART2
	} else if (rows[i][j] == '#' && adjecent >= 5) {
#else
	} else if (rows[i][j] == '#' && adjecent >= 4) {
#endif
		temp[i][j] = 'L';
		changed = true;
	} else
		temp[i][j] = rows[i][j];
}

int
main(void)
{
	/* Initialize the temp array to be all floor */
	int i, j;
	for (i = 0; i < ROWCNT; i++) {
		for (j = 0; j < ROWLEN; j++)
			temp[i][j] = '.';
	}

	FILE *fp;
	if (!(fp = fopen("input", "r")))
		err(EXIT_FAILURE, "fopen");

	/* Read in seats */
	i = j = 0;
	char c;
	while ((c = fgetc(fp)) != EOF) {
		if (c == '\n') {
			i = 0;
			j++;
		} else
			rows[j][i++] = c;
	}
	fclose(fp);

	/* Update the seats until they don't change anymore */
	do {
		changed = false;
		for (i = 0; i < ROWCNT; i++) {
			for (j = 0; j < ROWLEN; j++)
				check_seat(i, j);
		}

		for (i = 0; i < ROWCNT; i++) {
			for (j = 0; j < ROWLEN; j++)
				rows[i][j] = temp[i][j];
		}
	} while (changed);

	/* Calculate filled seats */
	int count = 0;
	for (i = 0; i < ROWCNT; i++) {
		for (j = 0; j < ROWLEN; j++) {
			if (rows[i][j] == '#')
				count++;
		}
	}

	printf("%d\n", count);
	return EXIT_SUCCESS;
}
