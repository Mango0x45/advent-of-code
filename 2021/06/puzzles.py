#!/usr/bin/env python3


# This is not my original solution, that one involved numpy and some more ugly code, but after
# seeing this solution I couldn't help but realize how obvious it was.


import collections
from typing import Counter


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		acc = collections.Counter(map(int, f.read().split(",")))

	for _ in range(DAYS):
		n = acc[0]
		for i in range(8):
			acc[i] = acc[i + 1]
		acc[6] += n
		acc[8] = n

	print(sum(acc.values()))


if __name__ == "__main__":
	main()
