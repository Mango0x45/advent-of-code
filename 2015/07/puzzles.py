#!/usr/bin/env python3

# START PART 2
from copy import deepcopy
# END PART 2

from numpy import uint16


recipes: dict[str, list[str] | uint16] = {}


def solve(wire: str) -> uint16:
	if wire.isdigit():
		return int(wire)
	if type(recipes[wire]) == uint16:
		return recipes[wire]

	match recipes[wire]:
		case [x]:
			recipes[wire] = solve(x)
		case ["NOT", x]:
			recipes[wire] = ~solve(x)
		case [x, "AND", y]:
			recipes[wire] = solve(x) & solve(y)
		case [x, "OR", y]:
			recipes[wire] = solve(x) | solve(y)
		case [x, "LSHIFT", y]:
			recipes[wire] = solve(x) << solve(y)
		case [x, "RSHIFT", y]:
			recipes[wire] = solve(x) >> solve(y)

	return recipes[wire]


def main() -> None:
	global recipes
	with open("input", "r", encoding="utf-8") as f:
		for line in f.readlines():
			line = line.strip().split(" ")
			recipes[line[-1]] = line[:-2]

	# START PART 2
	backup = deepcopy(recipes)
	backup["b"] = solve("a")
	recipes = backup
	# END PART 2
	print(solve("a"))


if __name__ == "__main__":
	main()
