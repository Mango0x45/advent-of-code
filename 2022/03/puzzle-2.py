#!/usr/bin/python3

from itertools import zip_longest


def grouper(xs: list[str], n: int) -> list[list[str]]:
	args = [iter(xs)] * n
	return zip_longest(*args)


def process(group: list[str, str, str]) -> int:
	x, y, z = group
	c = set(x.strip()).intersection(y.strip()).intersection(z.strip()).pop()
	return ord(c) - ord('a') + 1 if c >= 'a' else ord(c) - ord('A') + 27


def main() -> None:
	with open("input", "r") as f:
		print(sum(process(group) for group in grouper(f.readlines(), 3)))


if __name__ == "__main__":
	main()
