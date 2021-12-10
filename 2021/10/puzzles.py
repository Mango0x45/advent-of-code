#!/usr/bin/env python3

# START PART 1
import collections
from typing import Counter
# END PART 1 START PART 2
from functools import reduce
# END PART 2

OPEN = "([{<"


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = list(map(lambda l: l.strip(), f.readlines()))

	# START PART 1
	counts: Counter[int] = Counter()
	# END PART 1 START PART 2
	scores: list[int] = []
	# END PART 2

	for line in data:
		stack: list[int] = []
		for char in line:
			if char in OPEN:
				stack.append(char)
			elif (stack.pop(), char) not in (("(", ")"), ("[", "]"), ("{", "}"), ("<", ">")):
				# START PART 1
				counts[char] += 1
				# END PART 1
				break
		# START PART 2
		else:
			scores.append(reduce(lambda acc, n: acc * 5 + OPEN.index(n) + 1, reversed(stack), 0))
		# END PART 2

	# START PART 1
	print(counts[")"] * 3 + counts["]"] * 57 + counts["}"] * 1197 + counts[">"] * 25137)
	# END PART 1 START PART 2
	print(sorted(scores)[len(scores) // 2])
	# END PART 2

if __name__ == "__main__":
	main()
