#!/usr/bin/env sh

./seatids | awk -f puzzle-1.awk
./seatids | gawk -f puzzle-2.awk
