#!/usr/bin/env python3


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = list(map(lambda l: l.split("|")[1].strip().split(), f.readlines()))

	print(sum(sum(len(s) in (2, 3, 4, 7) for s in line) for line in data))


if __name__ == "__main__":
	main()
