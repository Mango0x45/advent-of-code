#define _GNU_SOURCE
#include <sys/types.h>

#include <ctype.h>
#include <err.h>
#include <stdio.h>
#include <stdlib.h>

static unsigned long long parse_number(void);
static unsigned long long parse_digit(void);
static unsigned long long parse_result(void);

#ifdef PART2
static unsigned long long parse_sum(void);
static unsigned long long parse_product(void);
#endif

char *g_current;

/* Convert the current number from a string to an int */
unsigned long long
parse_number(void)
{
	unsigned long long number = 0;
	while (isdigit(*g_current))
		number = number * 10 + *g_current++ - '0';

	return number;
}

/* Parse the current digit pointed to by `g_current` */
unsigned long long
parse_digit(void)
{
	if (isdigit(*g_current))
		return parse_number();

	/* If not a digit, it's a parenthesis */
	g_current++;
	unsigned long long result = parse_result();
	g_current++;
	return result;
}

#ifdef PART2
/* Parse and compute a sum */
unsigned long long
parse_sum(void)
{
	unsigned long long result = parse_digit();

	while (*g_current == '+') {
		g_current++;
		result += parse_digit();
	}

	return result;
}

/* Parse and compute a product */
unsigned long long
parse_product(void)
{
	unsigned long long result = parse_sum();

	while (*g_current == '*') {
		g_current++;
		result *= parse_sum();
	}

	return result;
}
#endif

/* Parse and compute a sum */
unsigned long long
parse_result(void)
{
#ifdef PART2
	return parse_product();
#else
	unsigned long long result = parse_digit();

	while (*g_current == '+' || *g_current == '*') {
		if (*g_current++ == '+')
			result += parse_digit();
		else
			result *= parse_digit();
	}

	return result;
#endif
}

/* Remove the spaces from user input */
static void
remove_spaces(char *str)
{
	char const *c = str;
	do
		while (*c == ' ')
			c++;
	while ((*str++ = *c++));
}

int
main(void)
{
	FILE *fp;
	char *line = NULL;
	size_t len = 0;
	ssize_t read;

	if (!(fp = fopen("input", "r")))
		err(EXIT_FAILURE, "fopen");

	unsigned long long acc = 0;
	while ((read = getline(&line, &len, fp)) != -1) {
		remove_spaces(line);
		g_current = line;
		acc += parse_result();
	}

	printf("%llu\n", acc);
	return EXIT_SUCCESS;
}
