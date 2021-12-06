#!/usr/bin/env python3

from collections import defaultdict
# START PART 2
from itertools import count
# END PART 2
from typing import DefaultDict, Literal


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		banks = tuple(map(int, f.read().split()))

	# START PART 1
	memory: DefaultDict[tuple[int, ...], Literal[0]] = defaultdict(int)
	# END PART 1 START PART 2
	inc = count(start=0, step=1)
	memory: DefaultDict[tuple[int, ...], int] = defaultdict(lambda: next(inc))
	# END PART 2

	while banks not in memory:
		memory[banks]
		i, v = max(enumerate(banks), key=lambda k: (k[1], -k[0]))

		banks = banks[:i] + (0,) + banks[i + 1 :]
		for _ in range(v):
			i = (i + 1) % 16
			banks = banks[:i] + ((banks[i] + 1),) + banks[i + 1 :]

	# START PART 1
	print(len(memory))
	# END PART 1 START PART 2
	print(len(memory) - memory[banks])
	# END PART 2


if __name__ == "__main__":
	main()
