#!/usr/bin/python3

from typing import NamedTuple, Self


class Vec2(NamedTuple):
	x: int
	y: int

	def __add__(self, other: Self) -> Self:
		return Vec2(self.x + other.x, self.y + other.y)

	def __sub__(self, other: Self) -> Self:
		return Vec2(self.x - other.x, self.y - other.y)


def main() -> None:
	with open("input", "r") as f:
		data = [line.rstrip().split(',') for line in f.readlines()]

	p1 = plot(data[0])
	p2 = plot(data[1])

	# START PART 1
	p1 = set(p1.keys())
	p2 = set(p2.keys())
	print(min(abs(x) + abs(y) for x, y in p1 & p2))
	# END PART 1 START PART 2
	print(min(p1[k] + p2[k] for k in p1.keys() if k in p2))
	# END PART 2


def plot(data: list[str]) -> dict[Vec2, int]:
	t = 0
	p = Vec2(0, 0)
	s: dict[Vec2, int] = {}

	VMAP = {
		'U': Vec2(0, +1),
		'D': Vec2(0, -1),
		'L': Vec2(-1, 0),
		'R': Vec2(+1, 0),
	}

	for spec in data:
		d, n = spec[0], int(spec[1:])
		v⃗ = VMAP[d]
		for _ in range(n):
			t += 1
			p += v⃗
			s[p] = t

	return s



if __name__ == "__main__":
	main()