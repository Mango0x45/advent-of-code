#!/usr/bin/python3

from itertools import product

from libaoc import matrix, read_int_matrix

rows: int
cols: int


def check(
	data: matrix[int],
	start: tuple[int, int]
# START PART 1
) -> bool:
# END PART 1 START PART 2
) -> int:
	p = 1
# END PART 2
	o = data[start[0]][start[1]]
	for di, dj in ((+1, 0), (-1, 0), (0, +1), (0, -1)):
		# START PART 2
		c = 0
		# END PART 2
		i, j = start
		while 0 < i < cols - 1 and 0 < j < rows - 1:
			i += di
			j += dj
			# START PART 2
			c += 1
			# END PART 2
			if data[i][j] >= o:
				break
	# START PART 1
		else:
			return True
	return False
	# END PART 1 START PART 2
		p *= c
	return p
	# END PART 2


def main() -> None:
	global rows, cols

	# START PART 1
	sum_or_max = sum
	# END PART 1 START PART 2
	sum_or_max = max
	# END PART 2

	with open("input", "r") as f:
		data = read_int_matrix(f)

	rows, cols = len(data), len(data[0])
	print(sum_or_max(check(data, (i, j)) for i, j in product(range(rows), range(cols))))


if __name__ == "__main__":
	main()
