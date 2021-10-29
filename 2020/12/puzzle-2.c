#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct coords {
	int north;
	int east;
};

int
main(void)
{
	FILE *fp;
	char cl[6];
	struct coords waypoint = {1, 10};
	struct coords ship = {0, 0};

	if (!(fp = fopen("input", "r")))
		err(EXIT_FAILURE, "fopen");

	while (fgets(cl, sizeof(cl), fp) != NULL) {
		switch (cl[0]) {
		case 'N':
			waypoint.north += atoi(&cl[1]);
			break;
		case 'E':
			waypoint.east += atoi(&cl[1]);
			break;
		case 'S':
			waypoint.north -= atoi(&cl[1]);
			break;
		case 'W':
			waypoint.east -= atoi(&cl[1]);
			break;
		case 'F':;
			unsigned int const val = atoi(&cl[1]);
			ship.north += val * waypoint.north;
			ship.east += val * waypoint.east;
			break;
		/* Left and right */
		default:;
			int direction = atoi(&cl[1]);

			/* (x, y) -> (-x, -y) */
			if (direction == 180) {
				waypoint.north = -waypoint.north;
				waypoint.east = -waypoint.east;
				break;
			}

			/* 0 <= direction < 360 */
			if (cl[0] == 'R')
				direction = -direction + 360;

			int const temp = waypoint.east;
			if (direction == 90) {
				/* (x, y) -> (-y, x) */
				waypoint.east = -waypoint.north;
				waypoint.north = temp;
			} else {
				/* (x, y) -> (y, -x) */
				waypoint.east = waypoint.north;
				waypoint.north = -temp;
			}
			break;
		}
	}
	fclose(fp);

	/* Absolute value */
	if (ship.north < 0)
		ship.north = -ship.north;
	if (ship.east < 0)
		ship.east = -ship.east;

	printf("%d\n", ship.north + ship.east);
	return EXIT_SUCCESS;
}
