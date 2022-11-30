#!/usr/bin/python3

import itertools
import re


def main() -> None:
	towns: set[str] = set()
	distances: list[tuple[str, str, int]] = []
	with open("input", "r", encoding="utf-8") as f:
		for line in f.readlines():
			f, t, d = re.match(r"(\w+) to (\w+) = (\d+)", line).groups()
			towns.update({f, t})
			distances.append((f, t, int(d)))

	print(
		# START PART 1
		min(
		# END PART 1 START PART 2
		max(
		# END PART 2
			sum(
				[d[2] for d in distances if part[0] in d and part[1] in d][0]
				for part in zip(perm, perm[1:])
			)
			for perm in itertools.permutations(towns)
		)
	)


if __name__ == "__main__":
	main()
