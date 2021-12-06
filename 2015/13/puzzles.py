#!/usr/bin/env python3

import re
from collections import defaultdict
from itertools import permutations
from typing import DefaultDict


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		entries = list(
			map(
				lambda e: [e[0], e[1], int(e[2]) if e[1] == "gain" else -int(e[2]), e[3]],
				(
					re.split(
						r"([^ ]+) would (gain|lose) (\d+) happiness units by sitting next to ([^"
						r" ]+).\n",
						line,
					)[1:-1]
					for line in f.readlines()
				),
			)
		)

	emap: DefaultDict[str, dict[str, int]] = defaultdict(lambda: {})
	for entry in entries:
		emap[entry[0]][entry[3]] = entry[2]
		# START PART 2
		emap[entry[0]]["Me"] = 0
		emap["Me"][entry[0]] = 0
		# END PART 2

	print(
		max(
			sum(
				emap[pair[0]][pair[1]] + emap[pair[1]][pair[0]]
				for pair in tuple(zip(perm, perm[1:])) + ((perm[-1], perm[0]),)
			)
			for perm in permutations(emap)
		)
	)


if __name__ == "__main__":
	main()
