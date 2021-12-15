#!/usr/bin/env python3

from heapq import heappop, heappush
from itertools import product
from typing import NamedTuple

from libaoc import matrix, read_int_matrix


class Node(NamedTuple):
	x: int
	y: int
	r: int

	def __lt__(self, other: tuple[int, int, int]) -> bool:
		return self.r < other.r


# START PART 2
def elongate(grid: matrix[int]) -> matrix[int]:
	ngrid: matrix[int] = []
	inc = lambda n: 1 if n == 9 else n + 1
	for p1 in grid:
		p2 = list(map(inc, p1))
		p3 = list(map(inc, p2))
		p4 = list(map(inc, p3))
		p5 = list(map(inc, p4))
		ngrid.append(p1 + p2 + p3 + p4 + p5)

	for i, j in product(range(4), range(l := len(grid))):
		ngrid.append(list(map(inc, ngrid[i * l + j])))

	return ngrid
# END PART 2


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		# START PART 1
		data = read_int_matrix(f)
		# END PART 1 START PART 2
		data = elongate(read_int_matrix(f))
		# END PART 2

	X_UPPER = len(data)
	Y_UPPER = len(data[0])

	heap = [Node(0, 0, 0)]
	visited = {(0, 0)}

	while heap:
		node = heappop(heap)
		if node.x == X_UPPER - 1 and node.y == Y_UPPER - 1:
			print(node.r)
			return

		for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
			xi = node.x + dx
			yi = node.y + dy

			if 0 <= xi < X_UPPER and 0 <= yi < Y_UPPER and (xi, yi) not in visited:
				visited.add((xi, yi))
				heappush(heap, Node(xi, yi, node.r + data[xi][yi]))


if __name__ == "__main__":
	main()
