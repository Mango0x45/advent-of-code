#!/usr/bin/python3

def main() -> None:
	points: set[complex] = set()

	with open("input", "r") as f:
		for i, line in enumerate(f.readlines()):
			for j, char in enumerate(line):
				if char in "#\n":
					continue
				points.add(pos := complex(j, i))
				if char == 'S':
					start = pos

	print(solve(start, points, 100, 2 if PUZZLE_PART == 1 else 20))

def solve(
	pos: complex,
	points: set[complex],
	minsave: int,
	maxcheat: int,
) -> int:
	path: list[complex] = []
	while points:
		path.append(pos)
		for v⃗ in [1, -1, 1j, -1j]:
			if (p := pos + v⃗) in points:
				break
		points.remove(pos)
		pos = p

	cnt = 0
	for i, p1 in enumerate(path):
		off = i + minsave
		for j, p2 in enumerate(path[off + 2:], off + 2):
			d = p1 - p2
			if abs(d.real) + abs(d.imag) <= min(j - off, maxcheat):
				cnt += 1
	return cnt

if __name__ == "__main__":
	main()