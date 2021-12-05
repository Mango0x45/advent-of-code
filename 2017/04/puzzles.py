#!/usr/bin/env python3


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		print(
			sum(
				map(
					lambda p: len(p) == len(set(p)),
					# START PART 1
					map (
						lambda l: l.split(), f.readlines()
					),
					# END PART 1 START PART 2
					map(
						lambda l: list(map(lambda w: "".join(sorted(w)), l.split())), f.readlines()
					),
					# END PART 2
				)
			)
		)


if __name__ == "__main__":
	main()
