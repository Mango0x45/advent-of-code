#!/usr/bin/env python3

import re

def main() -> None:
	replacements: dict[str, str] = {}
	with open("input", "r", encoding="utf-8") as f:
		for line in f.readlines():
			line = line.strip()
			if line != "":
				parts = line.split(" => ")
				if len(parts) == 2:
					while parts[0] in replacements:
						parts[0] += "_"
					replacements[parts[0]] = parts[1]
				else:
					molecule = line

	unique_molecules: set[str] = set()
	for pattern in replacements:
		trim_pattern = pattern.replace("_", "")
		for match in re.finditer(trim_pattern, molecule):
			before = molecule[:match.start()]
			after = molecule[match.start():].replace(trim_pattern, replacements[pattern], 1)
			unique_molecules.add(before + after)
	
	print(len(unique_molecules))

if __name__ == "__main__":
	main()
