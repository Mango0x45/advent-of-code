#!/usr/bin/python3

import itertools
from typing import Generator, Iterator, Self, TextIO


class Grid:
	@classmethod
	def from_file(cls, f: TextIO) -> Self:
		g = Grid()
		g._grid = mkmap(
			[[c for c in l if c != '\n'] for l in f.readlines()])
		return g

	def in_bounds_p(self, z: complex) -> bool:
		return (
			0 <= z.real < len(self._grid[0])
			and 0 <= z.imag < len(self._grid)
		)

	def accessablep(self, z: complex) -> bool:
		return self[z] is not None and self[z] < 4

	def indicies(self) -> Iterator[complex]:
		return itertools.starmap(complex, itertools.product(
			range(len(self._grid[0])),
			range(len(self._grid)),
		))

	def neighbors(self, z: complex) -> Generator[complex, None, None]:
		for Δ in (
			-1-1j, -1, -1+1j,
			 0-1j,      0+1j,
			+1-1j, +1, +1+1j,
		):
			if self.in_bounds_p(z + Δ):
				yield z + Δ

	def __getitem__(self, z: complex) -> int | None:
		return self._grid[int(z.real)][int(z.imag)]

	def __setitem__(self, z: complex, n: int | None) -> None:
		self._grid[int(z.real)][int(z.imag)] = n


def mkmap(xs: list[list[str]]) -> list[list[int]]:
	def get(pos: complex) -> str:
		r, i = map(int, (pos.real, pos.imag))
		if 0 <= r < len(xs[0]) and 0 <= i < len(xs):
			return xs[r][i]
		return '.'

	return [
		[
			sum(get(complex(i, j) + Δ) == '@' for Δ in [
				-1-1j, -1, -1+1j,
				 0-1j,      0+1j,
				+1-1j, +1, +1+1j,
			])
			if get(complex(i, j)) == '@'
			else None
			for j in range(len(xs[i]))
		]
		for i in range(len(xs))
	]


def main() -> None:
	with open('input', 'r') as f:
		grid = Grid.from_file(f)

	if PUZZLE_PART == 1:
		acc = sum(grid.accessablep(z) for z in grid.indicies())
	else:
		acc = 0
		while True:
			breakp = True
			for z in grid.indicies():
				if not grid.accessablep(z):
					continue
				breakp = False
				acc += 1
				grid[z] = None
				for p in grid.neighbors(z):
					if grid[p] is not None:
						grid[p] -= 1

			if breakp:
				break

	print(acc)


if __name__ == '__main__':
	main()
