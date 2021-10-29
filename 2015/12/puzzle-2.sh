#!/usr/bin/env sh

jq 'walk(if type == "object" then del(select(.[] == "red")) end)' input \
	| tr -c '\-0-9' '\n' \
	| squash \
	| paste -sd+ \
	| bc
