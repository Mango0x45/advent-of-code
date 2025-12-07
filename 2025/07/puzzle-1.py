#!/usr/bin/python3


def main() -> None:
	with open('input', 'r') as f:
		grid = tuple(tuple(x.strip()) for x in f.readlines())

	xs = set()
	xs.add(grid[0].index('S'))
	cnt = 0

	for row in grid[1:]:
		for i, ch in enumerate(row):
			if ch == '^' and i in xs:
				cnt += 1
				xs.remove(i)
				xs.add(i - 1)
				xs.add(i + 1)

	print(cnt)

if __name__ == '__main__':
	main()
