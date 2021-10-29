#include <sys/types.h>

#include <md5.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER 128
#ifdef PART2
	#define ZEROS     "000000"
	#define NUM_ZEROS 6
#else
	#define ZEROS     "00000"
	#define NUM_ZEROS 5
#endif

int
main(void)
{
	unsigned int i = 0;
	char buffer[MD5_DIGEST_STRING_LENGTH], digest[BUFFER];
	MD5_CTX ctx;

	do {
		snprintf(digest, BUFFER, INPUT "%u", i);

		MD5Init(&ctx);
		MD5Update(&ctx, (uint8_t *) digest, strlen(digest));
		MD5End(&ctx, buffer);
	} while (strncmp(buffer, ZEROS, NUM_ZEROS) && ++i);

	printf("%u\n", i);
	return EXIT_SUCCESS;
}
