#!/usr/bin/env python3

"""
Most of the code taken from this guys floodfill, I just adapted it for this problem
https://playandlearntocode.com/article/flood-fill-algorithm-in-python
"""

from functools import reduce
from itertools import product
from operator import mul

from libaoc import matrix, read_int_matrix


def is_basin(grid: matrix[int], row: int, col: int) -> bool:
	return (
		not ((row < 0 or row > len(grid) - 1) or (col < 0 or col > len(grid[0]) - 1))
		and grid[row][col] != 9
	)


def floodfill(grid: matrix[int], row: int, col: int) -> int:
	if row < 0 or row > len(grid) - 1 or col < 0 or col > len(grid[0]) - 1 or grid[row][col] == 9:
		return 0

	q: list[tuple[int, int]] = []
	grid[row][col] = 9
	q.append((row, col))
	size = 1

	while len(q):
		row, col = q.pop(0)

		for x, y in ((-1, 0), (1, 0), (0, -1), (0, 1)):
			c_row = row + x
			c_col = col + y

			if is_basin(grid, c_row, c_col):
				grid[c_row][c_col] = 9
				q.append((c_row, c_col))
				size += 1

	return size


def solve(grid: matrix[int]) -> int:
	return reduce(
		mul,
		sorted(
			map(
				lambda t: floodfill(grid, t[0], t[1]),
				filter(
					lambda t: grid[t[0]][t[1]] != 9, product(range(len(grid)), range(len(grid[0]))),
				),
			)
		)[-3:],
	)


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		print(solve(read_int_matrix(f)))


if __name__ == "__main__":
	main()
