#!/usr/bin/python3

import collections
import itertools


type Antennas = defaultdict[str, list[complex]]


def main() -> None:
	with open("input", "r") as f:
		data = [x.rstrip() for x in f.readlines()]
	w, h = len(data[0]), len(data)

	antennas: Antennas = collections.defaultdict(list)
	antinodes: set[complex] = set()

	for y, row in enumerate(data):
		for x, ch in enumerate(row):
			if ch != '.':
				antennas[ch].append(complex(x, y))

	for coords in antennas.values():
		for a, b in itertools.combinations(coords, 2):
			v⃗ = a - b
			u⃗ = b - a
			# START PART 1
			antinodes.add(a + u⃗*2)
			antinodes.add(b + v⃗*2)
			# END PART 1 START PART 2
			for i in range(1, max(w, h)):
				antinodes.add(a + u⃗*i)
				antinodes.add(b + v⃗*i)
			# END PART 2

	print(sum(0 <= x.real < w and 0 <= x.imag < h for x in antinodes))


if __name__ == "__main__":
	main()