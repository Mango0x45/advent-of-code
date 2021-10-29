#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int
main(void)
{
	FILE *fp;
	char cl[5];
	int north, east;
	int direction = 0;

	if (!(fp = fopen("input", "r")))
		err(EXIT_FAILURE, "fopen");

	north = east = 0;
	while (fgets(cl, sizeof(cl), fp) != NULL) {
		switch (cl[0]) {
		case 'N':
			north += atoi(&cl[1]);
			break;
		case 'E':
			east += atoi(&cl[1]);
			break;
		case 'S':
			north -= atoi(&cl[1]);
			break;
		case 'W':
			east -= atoi(&cl[1]);
			break;
		case 'L':
			direction -= atoi(&cl[1]);
			goto wrap;
		case 'R':
			direction += atoi(&cl[1]);

wrap:
			/* 0 <= direction < 360 */
			if (direction >= 360)
				direction -= 360;
			else if (direction < 0)
				direction += 360;
			break;
		case 'F':
			switch (direction) {
			case 0:
				east += atoi(&cl[1]);
				break;
			case 90:
				north -= atoi(&cl[1]);
				break;
			case 180:
				east -= atoi(&cl[1]);
				break;
			case 270:
				north += atoi(&cl[1]);
				break;
			}
			break;
		}
	}
	fclose(fp);

	/* Absolute value */
	if (north < 0)
		north = -north;
	if (east < 0)
		east = -east;

	printf("%d\n", north + east);
	return EXIT_SUCCESS;
}
