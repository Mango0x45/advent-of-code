#!/usr/bin/python3

import collections
import itertools


def main() -> None:
	g = collections.defaultdict(set)
	with open("input", "r") as f:
		for line in f.readlines():
			l, r = line.rstrip().split("-")
			g[l].add(r)
			g[r].add(l)

	# START PART 1
	cliques: set[tuple[str, str, str]] = set()
	# END PART 1 START PART 2
	minsz = 1
	clique: list[str] = []
	# END PART 2

	for x, s in g.items():
		# START PART 2
		for i in range(minsz + 1, len(s) + 1):
			# END PART 2 START PART 1
			i = 3
			# END PART 1
			nodes = tuple(s) + (x,)
			for comb in itertools.combinations(nodes, i):
				if cliquep(g, comb):
					# START PART 1
					if any(x[0] == 't' for x in comb):
						cliques.add(tuple(sorted(comb)))
					# END PART 1 START PART 2
					minsz = i
					clique = sorted(comb)
					# END PART 2

	# START PART 1
	print(len(cliques))
	# END PART 1 START PART 2
	print(','.join(clique))
	# END PART 2


def cliquep(g: dict[str, set[str]], nodes: tuple[str, ...]) -> bool:
	for i, x in enumerate(nodes):
		for y in nodes[i + 1:]:
			if x not in g[y]:
				return False
	return True


if __name__ == "__main__":
	main()