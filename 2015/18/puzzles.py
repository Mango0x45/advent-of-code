#!/usr/bin/python3


def neighbours(data: list[list[str]], x: int, y: int) -> int:
	acc = 0

	for x1, y1 in [
		(x - 1, y - 1),
		(x - 1, y    ),
		(x - 1, y + 1),
		(x,     y - 1),
		(x,     y + 1),
		(x + 1, y - 1),
		(x + 1, y    ),
		(x + 1, y + 1),
	]:
		try:
			if x1 >= 0 and y1 >= 0 and data[x1][y1] == "#":
				acc += 1
		except IndexError:
			pass

	return acc


def simulate(data: list[list[str]]) -> list[list[str]]:
	# START PART 1
	cond = lambda x, y: (data[x][y] == "#" and neighbours(data, x, y) in [2, 3]) or (
		data[x][y] == "." and neighbours(data, x, y) == 3
	)
	# END PART 1 START PART 2
	cond = lambda x, y: (
		((x, y) in [(0, 0), (0, 99), (99, 0), (99, 99)])
		or (data[x][y] == "#" and neighbours(data, x, y) in [2, 3])
		or (data[x][y] == "." and neighbours(data, x, y) == 3)
	)
	# END PART 2

	return [["#" if cond(i, j) else "." for j in range(100)] for i in range(100)]


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = [list(l.strip()) for l in f.readlines()]

	# START PART 2
	data[0][0], data[0][99], data[99][0], data[99][99] = "#", "#", "#", "#"
	# END PART 2

	for i in range(100):
		data = simulate(data)

	print(sum(data[i].count("#") for i in range(100)))


if __name__ == "__main__":
	main()
