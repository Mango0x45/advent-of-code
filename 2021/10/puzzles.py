#!/usr/bin/env python3

# START PART 1
from collections import Counter
# END PART 1


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		data = list(map(lambda l: l.strip(), f.readlines()))

	# START PART 1
	counts = Counter()
	# END PART 1 START PART 2
	scores = []
	# END PART 2

	for line in data:
		stack = []
		for char in line:
			if char in ("(", "[", "{", "<"):
				stack.append(char)
			elif (stack.pop(), char) not in (("(", ")"), ("[", "]"), ("{", "}"), ("<", ">")):
				# START PART 1
				counts[char] += 1
				# END PART 1
				break
		# START PART 2
		else:
			score = 0
			for char in reversed(stack):
				score *= 5
				if char == "(":
					score += 1
				elif char == "[":
					score += 2
				elif char == "{":
					score += 3
				elif char == "<":
					score += 4
			scores.append(score)
		# END PART 2

	# START PART 1
	print(counts[")"] * 3 + counts["]"] * 57 + counts["}"] * 1197 + counts[">"] * 25137)
	# END PART 1 START PART 2
	scores.sort()
	print(scores[len(scores) // 2])
	# END PART 2


if __name__ == "__main__":
	main()
