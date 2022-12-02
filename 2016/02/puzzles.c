#include <err.h>
#include <stdio.h>
#include <stdlib.h>

int
main(void)
{
	int x, y, ch;
#ifdef PART1
	int keypad[][5] = {
		{0, 0, 0, 0, 0},
		{0, 1, 2, 3, 0},
		{0, 4, 5, 6, 0},
		{0, 7, 8, 9, 0},
		{0, 0, 0, 0, 0}
#elif defined PART2
	int keypad[][7] = {
		{0, 0,  0,   0,   0,  0, 0},
		{0, 0,  0,   1,   0,  0, 0},
		{0, 0,  2,   3,   4,  0, 0},
		{0, 5,  6,   7,   8,  9, 0},
		{0, 0, 'A', 'B', 'C', 0, 0},
		{0, 0,  0,  'D',  0,  0, 0},
		{0, 0,  0,   0,   0,  0, 0},
#endif
	};
	FILE *fp = fopen("input", "r");

	if (fp == NULL)
		err(EXIT_FAILURE, "fopen: 'input'");

	x = y = 3;
	while ((ch = fgetc(fp)) != EOF) {
		switch (ch) {
		case 'U':
			if (keypad[y - 1][x] != 0)
				y--;
			break;
		case 'D':
			if (keypad[y + 1][x] != 0)
				y++;
			break;
		case 'L':
			if (keypad[y][x - 1] != 0)
				x--;
			break;
		case 'R':
			if (keypad[y][x + 1] != 0)
				x++;
			break;
		case '\n':
			putchar(keypad[y][x] <= 9
			        ? keypad[y][x] + '0'
			        : keypad[y][x]);
		}
	}

	putchar('\n');
	fclose(fp);
}
