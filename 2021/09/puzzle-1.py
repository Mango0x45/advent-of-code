#!/usr/bin/env python3


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = list(map(lambda l: [int(n) for n in l.strip()], f.readlines()))

	acc = 0
	rows = len(data[0])
	cols = len(data)

	for i in range(cols):
		for j in range(rows):
			if (
				i != 0
				and data[i - 1][j] <= data[i][j]
				or i != cols - 1
				and data[i + 1][j] <= data[i][j]
				or j != 0
				and data[i][j - 1] <= data[i][j]
				or j != rows - 1
				and data[i][j + 1] <= data[i][j]
			):
				continue

			acc += data[i][j] + 1

	print(acc)


if __name__ == "__main__":
	main()
