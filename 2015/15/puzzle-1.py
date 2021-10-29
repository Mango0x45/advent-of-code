#!/usr/bin/env python3

from math import prod
import itertools
import re


def main() -> None:
	data: list[list[int]] = []
	with open("input", "r", encoding="utf-8") as f:
		for line in f.readlines():
			m = re.match(
				r"[^\-0-9]+([\-0-9]+)[^\-0-9]+([\-0-9]+)[^\-0-9]+([\-0-9]+)[^\-0-9]+([\-0-9]+)",
				line,
			)
			data.append([int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4))])

	total: int = 0
	for i in range(100):
		for j in range(100 - i):
			for k in range(100 - i - j):
				if i + j + k > 100:
					continue
				h = 100 - i - j - k

				parts: list[int] = []
				parts.append(data[0][0] * i + data[1][0] * j + data[2][0] * k + data[3][0] * h)
				parts.append(data[0][1] * i + data[1][1] * j + data[2][1] * k + data[3][1] * h)
				parts.append(data[0][2] * i + data[1][2] * j + data[2][2] * k + data[3][2] * h)
				parts.append(data[0][3] * i + data[1][3] * j + data[2][3] * k + data[3][3] * h)

				if not any(map(lambda x: x < 0, parts)):
					total = max(total, prod(parts))

	print(total)


if __name__ == "__main__":
	main()
