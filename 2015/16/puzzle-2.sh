#!/bin/sh

# Definitely there is a better way to do this, but this is fine
# Original solution was just me using regex in vim lol

sed '/children/!s/$/, children: 3/' input           \
	| sed '/cats/!s/$/, cats: 8/'               \
	| sed '/samoyeds/!s/$/, samoyeds: 2/'       \
	| sed '/pomeranians/!s/$/, pomeranians: 2/' \
	| sed '/akitas/!s/$/, akitas: 0/'           \
	| sed '/vizslas/!s/$/, vizslas: 0/'         \
	| sed '/goldfish/!s/$/, goldfish: 4/'       \
	| sed '/trees/!s/$/, trees: 4/'             \
	| sed '/cars/!s/$/, cars: 2/'               \
	| sed '/perfumes/!s/$/, perfumes: 1/'       \
	| sed 's/$/ /'                              \
	| grep 'children: 3'                        \
	| grep 'samoyeds: 2'                        \
	| grep 'akitas: 0'                          \
	| grep 'vizslas: 0'                         \
	| grep 'cars: 2'                            \
	| grep 'perfumes: 1'                        \
	| grep 'goldfish: [0-4][ ,]'                \
	| grep 'pomeranians: [0-2][ ,]'             \
	| grep 'cats: \([8-9]\|[1-9][0-9]\)'        \
	| sed -n '/trees: \([4-9]\|[1-9][0-9]\)/s/Sue \([0-9]*\).*/\1/p'
