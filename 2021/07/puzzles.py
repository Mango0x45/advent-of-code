#!/usr/bin/env python3

import math


def gauss_sum(n: int) -> int:
	# START PART 1
	return n
	# END PART 1 START PART 2
	return n * (n + 1) // 2
	# END PART 2


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = list(map(int, f.read().split(",")))

	print(min(sum(gauss_sum(abs(i - data[j])) for j in range(len(data))) for i in range(max(data))))


if __name__ == "__main__":
	main()
