#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef PART1
	#define DIGITS ((size_t)(2))
#else
	#define DIGITS ((size_t)(12))
#endif

int
main(void)
{
	FILE *fp = fopen("input", "r");
	if (fp == nullptr)
		err(EXIT_FAILURE, "failed to open input");

	char *buf = nullptr;
	size_t acc, bufsz;
	ssize_t n;

	acc = bufsz = 0;

	while ((n = getline(&buf, &bufsz, fp)) != -1) {
		if (buf[n - 1] == '\n')
			buf[--n] = 0;

		char digits[DIGITS + 1];
		memcpy(digits, buf, DIGITS);
		digits[DIGITS] = 0;

		for (size_t i = 1; i < n - DIGITS + 1; i++) {
			for (size_t j = 0; j < DIGITS; j++) {
				if (buf[i + j] > digits[j])
					memcpy(digits + j, buf + i + j, DIGITS - j);
			}
		}

		acc += (size_t)strtol(digits, nullptr, 10);
	}
	if (ferror(fp))
		err(EXIT_FAILURE, "failed to read record");

	fclose(fp);
	printf("%zu\n", acc);
	return EXIT_SUCCESS;
}
