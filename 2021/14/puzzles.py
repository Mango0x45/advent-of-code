#!/usr/bin/env python3

from collections import Counter


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		formula = f.readline().strip()
		f.readline()

		data: dict[str, str] = {}
		for line in f.readlines():
			x, y = line.strip().split(" -> ")
			data[(x[0], x[1])] = y

	pairs = Counter(zip(formula, formula[1:]))

	for _ in range(LOOPS):
		new: Counter[str] = Counter()
		for pair in pairs:
			new[(pair[0], data[pair])] += pairs[pair]
			new[(data[pair], pair[1])] += pairs[pair]
		pairs = new

	# Ran out of memory, lol
	# chars = Counter(flatten(map(lambda p: (p[0],) * pairs[p], pairs)))

	chars: Counter[str] = Counter()
	for pair in pairs:
		chars[pair[0]] += pairs[pair]
	chars[formula[-1]] += 1

	print(chars.most_common()[0][1] - chars.most_common()[-1][1])


if __name__ == "__main__":
	main()
