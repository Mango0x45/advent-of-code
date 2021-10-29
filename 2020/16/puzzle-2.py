#!/usr/bin/env python3

from functools import reduce
from operator import mul


def not_reduced(label_dict: dict[int, str]) -> bool:
	for i in label_dict:
		if len(label_dict[i]) != 1:
			return True
	return False


def main() -> None:
	with open("input", "r") as f:
		data = f.readlines()

	i = 0
	valid: list[int] = []
	labels: list[str] = []
	while data[i] != "\n":
		labels.append(data[i].split(":")[0])
		ranges = data[i].split(": ")[1].split(" or ")
		for _range in ranges:
			bounds = tuple(map(int, _range.split("-")))
			for j in range(bounds[0], bounds[1] + 1):
				valid.append(j)
		i += 1

	# Skip to nearby tickets
	i += 5

	vtickets: list[tuple[int, ...]] = []
	for j in range(i, len(data)):
		fields = tuple(map(int, data[j].split(",")))
		check = True
		for field in fields:
			if field not in valid:
				check = False
				break
		if check == True:
			vtickets.append(tuple(map(int, data[j].split(","))))

	label_dict: dict[int, list[str]] = {}
	for i in range(len(labels)):
		label_dict[i] = []

	# Triple for loop, gross!
	for label in labels:
		valid: list[list[int]] = []
		ranges = data[labels.index(label)].split(": ")[1].split(" or ")
		for _range in ranges:
			bounds = tuple(map(int, _range.split("-")))
			for i in range(bounds[0], bounds[1] + 1):
				valid.append(i)

		# For each column
		for i in range(len(labels)):
			allvalid = True
			for ticket in vtickets:
				if ticket[i] not in valid:
					allvalid = False
					break

			if allvalid == True:
				label_dict[i].append(label)

	# Reduce the label dictionary
	while not_reduced(label_dict):
		for i in label_dict:
			if len((l := label_dict[i])) == 1:
				for j in label_dict:
					if l[0] in label_dict[j] and i != j:
						label_dict[j].remove(l[0])

	my_ticket = tuple(map(int, data[data.index("your ticket:\n") + 1].split(",")))
	print(reduce(mul, [x for x in my_ticket if "departure" in label_dict[my_ticket.index(x)][0]],))


if __name__ == "__main__":
	main()
