#!/usr/bin/env python3

from copy import deepcopy
from typing import Callable


def solve(lines: list[str], comp: Callable[[int, int], bool]) -> int:
	for i in range(len(lines[0])):
		if len(lines) == 1:
			break

		if comp(
			len([line for line in lines if line[i] == "0"]),
			len([line for line in lines if line[i] == "1"]),
		):
			lines = [line for line in lines if line[i] == "0"]
		else:
			lines = [line for line in lines if line[i] == "1"]

	return int(lines[0], 2)


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = [l.strip() for l in f.readlines()]

	print(solve(deepcopy(data), lambda x, y: x > y) * solve(data, lambda x, y: x <= y))


if __name__ == "__main__":
	main()
