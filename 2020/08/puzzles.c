#include <err.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LINECOUNT 653

struct Inst {
	char opp;
	int val;
};

/* Check if the given instruction has been executed already */
static bool
repeati(int const * const lines, int const rip)
{
	for (int i = 0; i < LINECOUNT; i++) {
		if (lines[i] == rip)
			return true;
	}
	return false;
}

static int
run_circuit(struct Inst *circuit)
{
	int i, acc, rip;
	int lines[LINECOUNT] = {0};

	i = acc = rip = 0;

	/* Execute the circuit */
	do {
		lines[i++] = rip;
		switch (circuit[rip].opp) {
		case 'j':
			rip += circuit[rip].val;
			if (rip >= LINECOUNT)
				return acc;
			break;
		case 'a':
			acc += circuit[rip].val;
			/* FALLTHROUGH */
		case 'n':
			rip++;
			break;
		}
	} while (!repeati(lines, rip));

#ifdef PART2
	return -1;
#else
	return acc;
#endif
}

int
main(void)
{
	int i = 0;
	char cl[10];
	FILE *fp;
	struct Inst circuit[LINECOUNT];

	if (!(fp = fopen("input", "r")))
		err(EXIT_FAILURE, "fopen");

	/* Load the entire circuit */
	while (fgets(cl, sizeof(cl), fp)) {
		char *val;
		/* struct Inst operation; */

		val = strtok(cl, " ");
		circuit[i++] = (struct Inst) {
			.opp = cl[0],
			.val = atoi(strtok(NULL, " "))
		};
	}
	fclose(fp);

	int result = -1;
#ifdef PART2
	int count, prev_count;
	count = prev_count = 1;

	/* Run circuit until it completes successfully */
	while (result == -1 && count < LINECOUNT) {
		for (i = 0; i < LINECOUNT; i++) {
			if (circuit[i].opp == 'j' || circuit[i].opp == 'n')
				count--;

			/* Swap jmp and nop */
			if (!count) {
				circuit[i].opp = (circuit[i].opp == 'j') ? 'n' : 'j';
				break;
			}
		}

		count = ++prev_count;
		result = run_circuit(circuit);

		/* Return to original array */
		circuit[i].opp = (circuit[i].opp == 'j') ? 'n' : 'j';
	}
#else
	result = run_circuit(circuit);
#endif

	printf("%d\n", result);
	return EXIT_SUCCESS;
}
