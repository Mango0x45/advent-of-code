#!/usr/bin/env python3

from collections import OrderedDict


def main() -> None:
	with open("input", "r") as f:
		data = f.readlines()

	i = 0
	rules: list[tuple[str]] = []
	while data[i] != "\n":
		rules.append(tuple(x for x in tuple(data[i].split(": "))))
		i += 1

	tests: list[str] = []
	for line in data:
		tests.append(line.strip())

	patterns: dict[str, list[str]] = {}

	# Get "a" and "b" out of the way to do less comparisons in the next loop. Also make use of
	# this loop to strip newlines off of all the rules.
	for rule in rules:
		rules[rules.index(rule)] = (rule[0], rule[1].strip())
		if len(rule[1]) == 4:
			patterns[rule[0]] = [rule[1][1]]

	while len(patterns) != len(rules):
		for rule in rules:
			if rule[0] in patterns:
				continue

			res = rule[1].split(" | ")
			req_rules = list(OrderedDict.fromkeys(" ".join(res).split(" ")))
			all_in = True
			for req in req_rules:
				if req not in patterns:
					all_in = False
					break
			if all_in == True:
				all_combos: list[str] = []
				for re in res:
					re = re.split(" ")
					if len(re) == 1:
						all_combos.extend(patterns[re[0]])
					else:
						for x in patterns[re[0]]:
							for y in patterns[re[1]]:
								all_combos.append(f"{x}{y}")
						all_combos = list(OrderedDict.fromkeys(all_combos))

				patterns[rule[0]] = all_combos

	print(len([test for test in tests if test in patterns["0"]]))


if __name__ == "__main__":
	main()
