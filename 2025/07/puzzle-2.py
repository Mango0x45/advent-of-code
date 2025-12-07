#!/usr/bin/python3

import collections
import functools


Pos = collections.namedtuple('Pos', ['x', 'y'])


def main() -> None:
	with open('input', 'r') as f:
		grid = tuple(tuple(x.strip()) for x in f.readlines())

	pos = Pos(grid[0].index('S'), 0)
	print(npaths(grid, pos))


@functools.cache
def npaths(grid: list[list[str]], pos: Pos) -> int:
	if pos.y == len(grid):
		return 1
	if grid[pos.y][pos.x] == '^':
		return (
			  npaths(grid, Pos(pos.x - 1, pos.y))
			+ npaths(grid, Pos(pos.x + 1, pos.y))
		)
	return npaths(grid, Pos(pos.x, pos.y + 1))


if __name__ == '__main__':
	main()
