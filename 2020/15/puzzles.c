#include <stdio.h>
#include <stdlib.h>

#ifndef PART2
	#define BUFFER 2020
#else
	#define BUFFER 30000000
#endif

int
main(void)
{
	/* Given starting numbers */
	static unsigned int nums[BUFFER] = {0};
	nums[6] = 1;
	nums[19] = 2;
	nums[0] = 3;
	nums[5] = 4;
	nums[7] = 5;
	nums[13] = 6;

	unsigned int temp, lnum = 1;
	for (int i = 8; i <= BUFFER; i++) {
		temp = lnum;
		lnum = nums[lnum] ? i - 1 - nums[lnum] : 0;
		nums[temp] = i - 1;
	}

	printf("%u\n", lnum);
	return EXIT_SUCCESS;
}
