#!/usr/bin/env python3

from collections import defaultdict


def solve(paths: defaultdict[list[str]], path: str, flag: bool = False) -> int:
	acc = 0
	tokens = path.split(",")

	for dest in paths[tokens[-1]]:
		if dest == "end":
			acc += 1
		# START PART 1
		elif not (dest.islower() and dest in tokens):
			acc += solve(paths, f"{path},{dest}")

	return acc


def main() -> None:
	paths: defaultdict[list[str]] = defaultdict(list)
	with open("input", "r", encoding="utf-8") as f:
		for entry in f.readlines():
			x, y = entry.strip().split("-")
			paths[x].append(y)
			paths[y].append(x)

	print(solve(paths, "start", False))


if __name__ == "__main__":
	main()
