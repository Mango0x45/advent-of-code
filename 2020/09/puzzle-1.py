#!/usr/bin/env python3
from typing import List


def is_valid(nums: List[int], lp: int, up: int) -> bool:
	for i in range(lp, up):
		x = nums[up] - nums[i]
		if x in nums[lp:up] and x != nums[i]:
			return True
	return False


def main() -> None:
	with open("input", "r") as f:
		nums = list(map(int, f.readlines()))

	lp = 0
	up = 25

	while is_valid(nums, lp, up):
		lp += 1
		up += 1

	print(nums[up])


if __name__ == "__main__":
	main()
