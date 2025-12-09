#!/usr/bin/python3

import itertools


type Point = tuple[int, int]


def main() -> None:
	with open('input', 'r') as f:
		xs = [tuple(map(int, l.split(','))) for l in f.readlines()]

	it = itertools.combinations(xs, 2)
	it = itertools.starmap(area, it)
	print(max(it))


def area(p: Point, q: Point) -> int:
	a, b = minmax(p[0], q[0])
	c, d = minmax(p[1], q[1])
	return (b - a + 1) * (d - c + 1)


def minmax(x: int, y: int) -> tuple[int, int]:
	return (x, y) if x < y else (y, x)


if __name__ == '__main__':
	main()
