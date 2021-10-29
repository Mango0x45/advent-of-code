#!/usr/bin/env sh

# Definitely there is a better way to do this, but this is fine
# Original solution was just me using regex in vim lol

sed '/children/!s/$/, children: 3/' input \
	| sed '/cats/!s/$/, cats: 7/' \
	| sed '/samoyeds/!s/$/, samoyeds: 2/' \
	| sed '/pomeranians/!s/$/, pomeranians: 3/' \
	| sed '/akitas/!s/$/, akitas: 0/' \
	| sed '/vizslas/!s/$/, vizslas: 0/' \
	| sed '/goldfish/!s/$/, goldfish: 5/' \
	| sed '/trees/!s/$/, trees: 3/' \
	| sed '/cars/!s/$/, cars: 2/' \
	| sed '/perfumes/!s/$/, perfumes: 1/' \
	| grep 'children: 3' \
	| grep 'cats: 7' \
	| grep 'samoyeds: 2' \
	| grep 'pomeranians: 3' \
	| grep 'akitas: 0' \
	| grep 'vizslas: 0' \
	| grep 'goldfish: 5' \
	| grep 'trees: 3' \
	| grep 'cars: 2' \
	| sed -n '/perfumes: 1/s/Sue \([0-9]*\).*/\1/p'
