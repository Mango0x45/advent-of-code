%{
#define _POSIX_C_SOURCE
#include <err.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/* Shut up the compiler */
int fileno(FILE *);

struct Instr {
	enum {
		HLF,
		INC,
		JIE,
		JIO,
		JMP,
		TPL
	} type;
	enum {
		A,
		B
	} reg;
	int imm;
};

int i = 0;
struct Instr *program;

#ifdef PART2
unsigned long long registers[2] = {1, 0};
#else
unsigned long long registers[2];
#endif
%}

%x ARGS

%%

hlf	{ program[i].type = HLF; BEGIN(ARGS); }
inc	{ program[i].type = INC; BEGIN(ARGS); }
jie	{ program[i].type = JIE; BEGIN(ARGS); }
jio	{ program[i].type = JIO; BEGIN(ARGS); }
jmp	{ program[i].type = JMP; BEGIN(ARGS); }
tpl	{ program[i].type = TPL; BEGIN(ARGS); }

<ARGS>[ab]		{ program[i].reg = *yytext - 'a'; }
<ARGS>[+\-][0-9]+	{ program[i].imm = atoi(yytext); }
<ARGS>[ ,]+		{ ; }
<ARGS>\n		{ i++; BEGIN(INITIAL); }

%%

static unsigned long long
execute(void)
{
	for (i = 0; i < PROGLEN; i++) {
		switch (program[i].type) {
		case HLF:
			registers[program[i].reg] /= 2;
			break;
		case INC:
			registers[program[i].reg]++;
			break;
		case JIE:
			if (!(registers[program[i].reg] & 1))
				i += program[i].imm - 1;
			break;
		case JIO:
			if (registers[program[i].reg] == 1)
				i += program[i].imm - 1;
			break;
		case JMP:
			i += program[i].imm - 1;
			break;
		case TPL:
			registers[program[i].reg] *= 3;
			break;
		}
	}

	return registers[B];
}

int
main(void)
{
	FILE *fp;

	if (!(program = calloc(PROGLEN, sizeof(struct Instr))))
		err(EXIT_FAILURE, "calloc");

	if (!(fp = fopen("input", "r")))
		err(EXIT_FAILURE, "fopen");

	yyrestart(fp);
	yylex();
	fclose(fp);

	printf("%llu\n", execute());
	return EXIT_SUCCESS;
}
