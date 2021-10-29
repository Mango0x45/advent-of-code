#include <err.h>
#include <stdio.h>
#include <stdlib.h>

#define BUFFER 200

int
main(void)
{
	int nums[BUFFER];
	FILE *fp;

	if (!(fp = fopen("input", "r")))
		err(EXIT_FAILURE, "fopen");

	for (int i = 0; i < BUFFER; i++)
		fscanf(fp, "%d", &nums[i]);

	fclose(fp);

	/* Inefficient, but small sample size so it's fine */
	for (int i = 0; i < BUFFER - 1; i++) {
		for (int j = i + 1; j < BUFFER; j++) {
#ifdef PART2
			for (int k = j + 1; k < BUFFER; k++) {
				if (nums[i] + nums[j] + nums[k] == 2020) {
					printf("%d\n", nums[i] * nums[j] * nums[k]);
					return EXIT_SUCCESS;
				}
			}
#else
			if (nums[i] + nums[j] == 2020) {
				printf("%d\n", nums[i] * nums[j]);
				return EXIT_SUCCESS;
			}
#endif
		}
	}
}
