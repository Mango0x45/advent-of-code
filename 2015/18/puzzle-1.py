#!/usr/bin/env python3


def neighbours(data: list[list[str]], x: int, y: int) -> int:
	acc = 0

	for x1, y1 in [
		(x - 1, y - 1),
		(x - 1, y),
		(x - 1, y + 1),
		(x, y - 1),
		(x, y + 1),
		(x + 1, y - 1),
		(x + 1, y),
		(x + 1, y + 1),
	]:
		try:
			if x1 >= 0 and y1 >= 0 and data[x1][y1] == "#":
				acc += 1
		except IndexError:
			pass

	return acc


def simulate(data: list[list[str]]) -> list[list[str]]:
	ndata = [["." for i in range(100)] for j in range(100)]

	for i in range(100):
		for j in range(100):
			if data[i][j] == "#" and neighbours(data, i, j) in [2, 3]:
				ndata[i][j] = "#"
			elif data[i][j] == "." and neighbours(data, i, j) == 3:
				ndata[i][j] = "#"

	return ndata

def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = [list(l.strip()) for l in f.readlines()]

	for i in range(100):
		data = simulate(data)

	print(sum(data[i].count("#") for i in range(100)))


if __name__ == "__main__":
	main()
