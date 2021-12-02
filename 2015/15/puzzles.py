#!/usr/bin/env python3

import itertools
import re
from math import prod


def main() -> None:
	data: list[list[int]] = []
	with open("input", "r", encoding="utf-8") as f:
		for line in f.readlines():
			m = re.match(
				# START PART 1
				r"[^\-0-9]+([\-0-9]+)[^\-0-9]+([\-0-9]+)[^\-0-9]+([\-0-9]+)[^\-0-9]+([\-0-9]+)",
				# END PART 1 START PART 2
				r"[^\-0-9]+([\-0-9]+)[^\-0-9]+([\-0-9]+)[^\-0-9]+([\-0-9]+)[^\-0-9]+([\-0-9]+)[^\-0-9]+([0-9]+)",
				# END PART 2
				line,
			)
			data.append(list(map(int, [m.group(i) for i in range (1, GROUPS)])))

	total = 0
	for i in range(100):
		for j in range(100 - i):
			for k in range(100 - i - j):
				if i + j + k > 100:
					continue
				h = 100 - i - j - k
				# START PART 2
				if data[0][4] * i + data[1][4] * j + data[2][4] * k + data[3][4] * h != 500:
					continue
				# END PART 2

				parts = [
					data[0][0] * i + data[1][0] * j + data[2][0] * k + data[3][0] * h,
					data[0][1] * i + data[1][1] * j + data[2][1] * k + data[3][1] * h,
					data[0][2] * i + data[1][2] * j + data[2][2] * k + data[3][2] * h,
					data[0][3] * i + data[1][3] * j + data[2][3] * k + data[3][3] * h,
				]

				if not any(map(lambda x: x < 0, parts)):
					total = max(total, prod(parts))

	print(total)


if __name__ == "__main__":
	main()
