#include <err.h>
#include <stdio.h>
#include <stdlib.h>

int
main(void)
{
	int n, s;
	int *jumps;
	FILE *fp;

	if (!(jumps = calloc(PROGLEN, sizeof(int))))
		err(EXIT_FAILURE, "calloc");
	if (!(fp = fopen("input", "r")))
		err(EXIT_FAILURE, "fopen");
	for (int i = 0; fscanf(fp, "%d", &n) != EOF; i++)
		jumps[i] = n;
	fclose(fp);

	s = 0;
	for (int i = 0; i >= 0 && i < PROGLEN; s++) {
#ifdef PART2
		if (jumps[i] >= 3) {
			jumps[i]--;
			i += jumps[i] + 1;
		} else {
			jumps[i]++;
			i += jumps[i] - 1;
		}
#else
		jumps[i]++;
		i += jumps[i] - 1;
#endif
	}

	printf("%d\n", s);
	return EXIT_SUCCESS;
}
