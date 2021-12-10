#!/usr/bin/env sh

sed -f puzzle-1.sed input | paste -sd+ | bc
sed -f puzzle-2.sed input | bc | sort -n | sed '27!d'
