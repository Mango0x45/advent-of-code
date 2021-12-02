#!/usr/bin/env python3

import itertools


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		nums = list(map(int, f.readlines()))

	print(
		len(
			list(
				filter(
					lambda x: sum(x) == 150,
					list(
						itertools.chain(
							*[list(itertools.combinations(nums, n)) for n in range(len(nums) + 1)]
						)
					),
				)
			)
		)
	)


if __name__ == "__main__":
	main()
