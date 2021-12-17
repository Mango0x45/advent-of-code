#!/usr/bin/env python3

import re
from itertools import product
from math import inf
from typing import NamedTuple, Optional


class Range(NamedTuple):
	minx: int
	maxx: int
	miny: int
	maxy: int


def fire(r: Range, dy: int, dx: int) -> Optional[int]:
	x, y = 0, 0
	h = -inf
	while x <= r.maxx and y >= r.miny:
		x += dx
		y += dy

		if dx > 0:
			dx -= 1
		elif dx < 0:
			dx += 1
		dy -= 1
		h = max(h, y)

		if r.minx <= x <= r.maxx and r.miny <= y <= r.maxy:
			return h
	return None


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		m = re.split(r"target area: x=(\d+)..(\d+), y=(-?\d+)..(-?\d+)", f.read())
	r = Range(*tuple(map(int, m[1:-1])))

	xr = max(abs(r.minx), abs(r.maxx))
	yr = max(abs(r.miny), abs(r.maxy))

	heights = tuple(
		filter(
			lambda h: h != None,
			(fire(r, x, y) for x, y in product(range(-yr, yr + 1), range(-xr, xr + 1))),
		)
	)
	# START PART 1
	print(max(heights))
	# END PART 1 START PART 2
	print(len(heights))
	# END PART 2


if __name__ == "__main__":
	main()
