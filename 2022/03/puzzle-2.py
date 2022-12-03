#!/usr/bin/python3

from itertools import zip_longest


def grouper(xs: list[str], n: int) -> list[list[str]]:
	args = [iter(xs)] * n
	return zip_longest(*args)


def main() -> None:
	with open("input", "r") as f:
		data = f.readlines()

	acc = 0
	data = grouper(data, 3)

	for group in data:
		for c in group[0]:
			if group[1].find(c) != -1 and group[2].find(c) != -1:
				if 'a' <= c <= 'z':
					acc += ord(c) - ord('a') + 1
				else:
					acc += ord(c) - ord('A') + 27
				break

	print(acc)


if __name__ == "__main__":
	main()
