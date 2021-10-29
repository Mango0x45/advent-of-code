#include <stdio.h>
#include <stdlib.h>

int
main(void)
{
	int c;
	FILE *fp = fopen("input", "r");

	register int floor = 0;
	for (register unsigned int i = 1; (c = fgetc(fp)) != EOF; i++) {
		floor += (c == '(') ? 1 : -1;
#ifdef PART2
		if (floor == -1) {
			printf("%u\n", i);
			return EXIT_SUCCESS;
		}
#endif
	}

	fclose(fp);
	printf("%d\n", floor);

	return EXIT_SUCCESS;
}
