#!/usr/bin/env python3


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		nums = [int(n) for n in f.readlines()]

	print(sum(n < m for n, m in zip(nums, nums[DELTA:])))


if __name__ == "__main__":
	main()
