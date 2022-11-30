#!/usr/bin/python3

import re


def main() -> None:
	replacements: dict[str, str] = {}
	with open("input", "r", encoding="utf-8") as f:
		for line in f.readlines():
			match line.strip().split(" => "):
				case [before, after]:
					while before in replacements:
						before += "_"
					replacements[before] = after
				case [mol]:
					molecule = mol

	unique_molecules: set[str] = set()
	for pattern in replacements:
		trim_pattern = pattern.rstrip("_")
		unique_molecules.update(
			molecule[: match.start()]
			+ molecule[match.start() :].replace(trim_pattern, replacements[pattern], 1)
			for match in re.finditer(trim_pattern, molecule)
		)

	print(len(unique_molecules))


if __name__ == "__main__":
	main()
