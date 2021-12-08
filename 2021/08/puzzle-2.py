#!/usr/bin/env python3

import itertools


def solve(nums: list[str]) -> int:
	nummap: dict[str, set[str]] = {}

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
				elif set(nummap[4]).issubset(set(s).union(set(nummap[1]))):
					nummap[5] = s
				else:
					nummap[2] = s
			# 0, 6, or 9
			case 6:
				# 1 is a subset of 6 but not 0 or 9
				if not set(nummap[1]).issubset(set(s)):
					nummap[6] = s
				# 4 is a subset of 9 but not 0
				elif set(nummap[4]).issubset(set(s)):
					nummap[9] = s
				else:
					nummap[0] = s
	
	nums = nums[nums.index("|") + 1 :]

	acc = 0
	for n, (k, v) in itertools.product(nums, nummap.items()):
		if set(v) == set(n):
			acc = acc * 10 + int(k)
	return acc


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = list(map(lambda l: l.strip().split(), f.readlines()))

	print(sum(solve(line) for line in data))


if __name__ == "__main__":
	main()
