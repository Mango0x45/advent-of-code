#!/bin/sh

{
	printf '('
	for i in $(seq "$(head -n1 input | wc -c)")
	do
		num="$(cut -c $i input | paste -sd '')"
		num="${num%${num##*[![:space:]]}}"

		case "$num" in
		*[+*])
			test -n "$op" && printf ') + ('
			op="${num#${num%?}}"
			num="${num%?}"
			printf '%d %s ' $num "$op"
			;;
		'')
			test "$op" = +
			printf '%d' $?
			;;
		*)
			printf '%d %s ' $num "$op"
			;;
		esac
	done
	printf ')\n'
} | bc
