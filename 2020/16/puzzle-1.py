#!/usr/bin/env python3


def main() -> None:
	with open("input", "r") as f:
		data = f.readlines()

	i = 0
	valid: list[int] = []
	while data[i] != "\n":
		ranges = data[i].split(": ")[1].split(" or ")
		for _range in ranges:
			bounds = tuple(map(int, _range.split("-")))
			for j in range(bounds[0], bounds[1] + 1):
				valid.append(j)
		i += 1

	# Skip to nearby tickets
	i += 5
	acc = 0

	for j in range(i, len(data)):
		fields = tuple(map(int, data[j].split(",")))
		acc += sum(field for field in fields if field not in valid)

	print(acc)


if __name__ == "__main__":
	main()
