#!/usr/bin/env python3

import itertools


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		nums = list(map(int, f.readlines()))

	combs: list[tuple[int, ...]] = []
	for n in range(len(nums) + 1):
		combs += list(itertools.combinations(nums, n))

	combs = list(filter(lambda x: sum(x) == 150, combs))
	conts = min(map(len, combs))
	print(len(list(filter(lambda x: len(x) == conts, combs))))


if __name__ == "__main__":
	main()
