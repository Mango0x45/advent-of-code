#!/usr/bin/python3

import functools
import heapq
import itertools
import math
import operator


type Point = tuple[int, int, int]
type Circuit = set[Point]


def main() -> None:
	with open('input', 'r') as f:
		boxes = [tuple(map(int, l.split(','))) for l in f.readlines()]

	circuits: list[Circuit] = []
	pairs = itertools.combinations(boxes, 2)
	pairs = iter(sorted(pairs, key=lambda p: math.dist(*p)))

# START PART 1
	for p, q in itertools.islice(pairs, 1000):
		connect(circuits, p, q)

	lens = heapq.nlargest(3, map(len, circuits))
	print(functools.reduce(operator.mul, lens))
# END PART 1 START PART 2
	while len(circuits) != 1 or len(circuits[0]) != len(boxes):
		p, q = next(pairs)
		connect(circuits, p, q)
	print(p[0] * q[0])
# END PART 2


def connect(circuits: list[Circuit], p: Point, q: Point) -> None:
	pc = next((c for c in circuits if p in c), None)
	qc = next((c for c in circuits if q in c), None)

	match (pc, qc):
		case (None, None):
			circuits.append({p, q})
		case (x, None):
			pc.add(q)
		case (None, y):
			qc.add(p)
		case (x, y) if x is not y:
			circuits.remove(qc)
			pc |= qc


if __name__ == '__main__':
	main()
