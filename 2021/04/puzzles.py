#!/usr/bin/env python3

board = list[list[int]]
last: board = [[]] * 5


def bingo(board: board) -> bool:
	global last

	if any(
		board[0][i] == board[1][i]
		and board[1][i] == board[2][i]
		and board[2][i] == board[3][i]
		and board[3][i] == board[4][i]
		or len(set(board[i])) == 1
		for i in range(5)
	):
		last = board
		return True

	return False


def main() -> None:
	boards: list[board] = []
	with open("input", "r", encoding="utf-8") as f:
		draws = list(map(int, f.readline().split(",")))
		lines = f.readlines()
		for i, line in enumerate(lines):
			if line == "\n":
				boards.append([list(map(int, lines[i + j].split())) for j in range(1, 6)])

	# START PART 1
	while not any(bingo(b) for b in boards):
	# END PART 1 START PART 2
	while len(draws) > 0 and len(boards) > 0:
	# END PART 2
		num = draws.pop(0)
		for board in boards:
			for i, row in enumerate(board):
				board[i] = [-1 if n == num else n for n in row]
		# START PART 2
		boards = list(filter(lambda b: not bingo(b), boards))
		# END PART 2

	print(num * sum(map(lambda x: sum(filter(lambda n: n != -1, x)), last)))


if __name__ == "__main__":
	main()
