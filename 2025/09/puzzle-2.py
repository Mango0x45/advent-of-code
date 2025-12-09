#!/usr/bin/python3

import itertools


type Point = tuple[int, int]
type Box = tuple[int, int, int, int]


def main() -> None:
	with open('input', 'r') as f:
		xs = [tuple(map(int, l.split(','))) for l in f.readlines()]

	it = itertools.pairwise(xs)
	it = itertools.starmap(tobox, it)
	ys = list(it)

	n = 0
	it = itertools.combinations(xs, 2)
	it = itertools.starmap(tobox, it)
	for x in it:
		if (_area := area(x)) <= n:
			continue
		a, b, c, d = x
		for p, q, r, s in ys:
			if a < r and b < s and c > p and d > q:
				break
		else:
			n = _area

	print(n)


def tobox(p: Point, q: Point) -> Box:
	a, b = minmax(p[0], q[0])
	c, d = minmax(p[1], q[1])
	return a, c, b, d


def area(b: Box) -> int:
	return (b[2] - b[0] + 1) * (b[3] - b[1] + 1)


def minmax(x: int, y: int) -> tuple[int, int]:
	return (x, y) if x < y else (y, x)


if __name__ == '__main__':
	main()
