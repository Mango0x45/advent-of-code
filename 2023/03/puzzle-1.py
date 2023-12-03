#!/usr/bin/python

import re


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = f.read()

	symbols = set()
	matches = []

	lines = [line for line in data.split('\n') if line]
	for i, line in enumerate(lines):
		for match in re.finditer(r'\d+', line):
			matches.append((i, match))
		for match in re.finditer(r'[^0-9.]', line):
			symbols.add((i, match.start()))

	acc = 0
	for match in matches:
		l, m = match
		s, e = m.span()
		ps = [(l, s-1), (l, e)]
		for i in range(s-1, e+1):
			ps.append((l-1, i))
			ps.append((l+1, i))
		for p in ps:
			if p in symbols:
				acc += int(m.group(0))

	print(acc)

if __name__ == "__main__":
	main()
