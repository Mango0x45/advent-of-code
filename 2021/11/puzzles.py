#!/usr/bin/env python3

# START PART 1
from itertools import product
# END PART 1 START PART 2
from itertools import chain, count, product
# END PART 2

matrix = list[list[int]]
rows, cols = -1, -1


def flash(grid: matrix, i: int, j: int) -> int:
	acc = 1
	grid[i][j] = -1

	for di, dj in ((-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)):
		ni = i + di
		nj = j + dj
		if 0 <= ni < rows and 0 <= nj < cols and grid[ni][nj] != -1:
			grid[ni][nj] += 1
			if grid[ni][nj] > 9:
				acc += flash(grid, ni, nj)

	return acc


def main() -> None:
	global rows, cols

	with open("input", "r", encoding="utf-8") as f:
		grid = list(map(lambda l: [int(n) for n in l.strip()], f.readlines()))

	rows = len(grid)
	cols = len(grid[0])

	acc = 0
	# START PART 1
	for _ in range(100):
	# END PART 1 START PART 2
	for step in count(1):
	# END PART 2
		for i, j in product(range(rows), range(cols)):
			grid[i][j] += 1

		for i, j in product(range(rows), range(cols)):
			if grid[i][j] > 9:
				acc += flash(grid, i, j)

		# START PART 2
		if sum(chain.from_iterable(grid)) == -(rows * cols):
			print(step)
			return
		# END PART 2

		for i, j in product(range(rows), range(cols)):
			if grid[i][j] == -1:
				grid[i][j] = 0

	# START PART 1
	print(acc)
	# END PART 1


if __name__ == "__main__":
	main()
