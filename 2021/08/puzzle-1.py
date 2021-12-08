#!/usr/bin/env python3


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		print(
			sum(
				map(
					lambda l: sum(map(lambda s: len(s) in (2, 3, 4, 7), l)),
					map(lambda l: l.split("|")[1].strip().split(), f.readlines()),
				)
			)
		)


if __name__ == "__main__":
	main()
