#!/usr/bin/env python3

import subprocess

import numpy as np


def main() -> None:
	goal = int(subprocess.run(["./puzzle-1.py"], capture_output=True, text=True).stdout)
	with open("input", "r", encoding="utf-8") as f:
		nums = np.array(list(map(int, f.readlines())), dtype=int)

	lp = 0
	up = 1

	while (x := sum(nums[lp : up + 1])) != goal:
		if x > goal:
			up -= 1
			lp += 1
		elif x < goal:
			up += 1

	sorted = np.sort(nums[lp : up + 1])
	print(sorted[0] + sorted[-1])


if __name__ == "__main__":
	main()
