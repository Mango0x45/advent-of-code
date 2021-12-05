#include <err.h>
#include <stdio.h>
#include <stdlib.h>

#define ODD(x) (x & 1)
#define MOVE(x)                                                                                    \
	do {                                                                                       \
		for (int k = 0; k < j; k++) {                                                      \
			x;                                                                         \
			if (++m == n)                                                              \
				goto out;                                                          \
		}                                                                                  \
	} while (0)

int
main(void)
{
	int n, x, y;
	FILE *fp;

	if (!(fp = fopen("input", "r")))
		err(EXIT_FAILURE, "fopen");

	fscanf(fp, "%d", &n);
	fclose(fp);

	x = y = 0;
	for (int i = 1, m = 1, j = 1; i < n; i++) {
		if (ODD(i)) {
			if (ODD(j))
				MOVE(x++);
			else
				MOVE(x--);
		} else {
			if (ODD(j))
				MOVE(y++);
			else
				MOVE(y--);
			j++;
		}
	}
out:
	if (x < 0)
		x = -x;
	if (y < 0)
		y = -y;

	printf("%d\n", x + y);
	return EXIT_SUCCESS;
}
