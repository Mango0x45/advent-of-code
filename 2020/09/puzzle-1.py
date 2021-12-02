#!/usr/bin/env python3


def is_valid(nums: list[int], lp: int, up: int) -> bool:
	return any(((x := nums[up] - nums[i]) in nums[lp:up] and x != nums[i]) for i in range(lp, up))


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		nums = list(map(int, f.readlines()))

	lp = 0
	up = 25

	while is_valid(nums, lp, up):
		lp += 1
		up += 1

	print(nums[up])


if __name__ == "__main__":
	main()
