#!/usr/bin/python3

import itertools


def main() -> None:
	keys: list[int] = []
	locks: list[int] = []

	with open("input", "r") as f:
		schems = f.read().split("\n\n")

	for schem in schems:
		n = 0
		for char in schem:
			if char == '\n':
				continue
			n <<= 1
			if char == '#':
				n |= 1
		(locks if n >= 0x7C0000000 else keys).append(n)

	def nand(x: int, y: int) -> bool:
		return not x & y

	print(sum(itertools.starmap(nand, itertools.product(keys, locks))))


if __name__ == "__main__":
	main()