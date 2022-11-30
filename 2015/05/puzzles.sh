#!/bin/sh

# Could do this with just grep(1) and skip using wc(1), but I am lazy

sed -Enf puzzle-1.sed input | wc -l
sed -Enf puzzle-2.sed input | wc -l
