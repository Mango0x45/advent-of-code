#!/usr/bin/env sh

# Could do this with just grep(1) and skip using wc(1), but I am lazy

sed -nf puzzle-1.sed input | wc -l
sed -nf puzzle-2.sed input | wc -l
