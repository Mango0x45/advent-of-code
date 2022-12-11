#!/usr/bin/python3

# START PART 1
SEGMENTS = 2
# END PART 1 START PART 2
SEGMENTS = 10
# END PART 2

position = tuple[int, int]


class Segment:
	def __init__(self):
		self.x = 0
		self.y = 0

	def track(self, pos: position) -> None:
		x, y = pos
		dx = x - self.x
		dy = y - self.y
		nx = 1 if dx > 0 else -1
		ny = 1 if dy > 0 else -1

		match (abs(dx), abs(dy)):
			case (2, 0):
				self.x += nx
			case (0, 2):
				self.y += ny
			case (2, 1) | (2, 2) | (1, 2):
				self.x += nx
				self.y += ny

	@property
	def pos(self) -> position:
		return self.x, self.y


def main() -> None:
	with open("input", "r") as f:
		data = [(xs[0], int(xs[1])) for xs in [l.split() for l in f.readlines()]]

	snake = [Segment() for _ in range(SEGMENTS)]
	head = snake[0]
	tail = snake[-1]
	locs: set[position] = set()

	for d, c in data:
		for _ in range(c):
			match d:
				case "U":
					head.y += 1
				case "D":
					head.y -= 1
				case "R":
					head.x += 1
				case "L":
					head.x -= 1

			for i, segment in enumerate(snake[1:]):
				segment.track(snake[i].pos)

			locs.add(tail.pos)

	print(len(locs))


if __name__ == "__main__":
	main()
