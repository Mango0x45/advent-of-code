#!/usr/bin/env python3


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = list(map(int, f.read().split(",")))

	# START PART 1
	gauss_sum = lambda n: n
	# END PART 1 START PART 2
	gauss_sum = lambda n: n * (n + 1) // 2
	# END PART 2

	print(min(sum(gauss_sum(abs(i - n)) for n in data) for i in range(min(data), max(data) + 1)))


if __name__ == "__main__":
	main()
