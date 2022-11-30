#!/bin/sh

jq 'walk(if type == "object" then del(select(.[] == "red")) else . end)' input \
	| tr -c '\-0-9' '\n'                                                   \
	| grep .                                                               \
	| paste -sd+                                                           \
	| bc
