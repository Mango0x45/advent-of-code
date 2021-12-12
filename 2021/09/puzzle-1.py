#!/usr/bin/env python3


from itertools import product

from libaoc import read_int_matrix


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = read_int_matrix(f)

	acc = 0
	rows = len(data)
	cols = len(data[0])

	for i, j in product(range(rows), range(cols)):
		if (
			i != 0
			and data[i - 1][j] <= data[i][j]
			or i != cols - 1
			and data[i + 1][j] <= data[i][j]
			or j != 0
			and data[i][j - 1] <= data[i][j]
			or j != rows - 1
			and data[i][j + 1] <= data[i][j]
		):
			continue

		acc += data[i][j] + 1

	print(acc)


if __name__ == "__main__":
	main()
