#!/usr/bin/env python3


# This is not my original solution, that one involved numpy and some more ugly code, but after
# seeing this solution I couldn't help but realize how obvious it was.


import collections
from typing import Counter


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		acc = collections.Counter(map(int, f.read().split(",")))

	for _ in range(DAYS):
		counts: Counter[int] = collections.Counter()
		for a, c in acc.items():
			if a:
				counts[a - 1] += c
			else:
				counts[6] += c
				counts[8] += c

		acc = counts

	print(sum(acc.values()))


if __name__ == "__main__":
	main()
