#!/usr/bin/env python3

import itertools


def solve(nums: list[str]) -> int:
	nummap: list[set[str]] = [None for _ in range(10)]

	# First pass, find the easy patterns. From these 4 patterns you can determine all other ones
	for n in nums:
		nummap[[0, 0, 1, 7, 4, 0, 0, 8][len(n)]] = set(n)

	# Second pass, here we use the magic of sets to work out all the other numbers from the 4
	# that we found above
	for n in nums:
		match len((s := set(n))):
			# 2, 3, or 5
			case 5:
				# 1 is a subset of 3 and none of the others
				if nummap[1].issubset(s):
					nummap[3] = s
				# 4 is a subset of 5 union with 1 but not 2 union with 1
				elif nummap[4].issubset(s.union(nummap[1])):
					nummap[5] = s
				else:
					nummap[2] = s
			# 0, 6, or 9
			case 6:
				# 1 is a subset of 6 but not 0 or 9
				if not nummap[1].issubset(s):
					nummap[6] = s
				# 4 is a subset of 9 but not 0
				elif nummap[4].issubset(s):
					nummap[9] = s
				else:
					nummap[0] = s

	acc = 0
	for n, (i, v) in itertools.product(nums[nums.index("|") + 1 :], enumerate(nummap)):
		if set(n) == v:
			acc = acc * 10 + i
	return acc


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		print(sum(map(solve, map(lambda l: l.strip().split(), f.readlines()))))


if __name__ == "__main__":
	main()
