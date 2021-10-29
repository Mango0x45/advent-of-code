#!/usr/bin/env python3


bdict: dict[str, list[str]] = {}

# Recursively check if a bag can hold a shiny gold bag
def holds_bag(innerbags: list[str]) -> bool:
	if "no other" in innerbags:
		return False
	elif "shiny gold" in innerbags:
		return True

	for subbag in innerbags:
		if holds_bag(bdict[subbag]):
			return True


def main() -> None:
	global bdict
	with open("input", "r") as f:
		lines = f.readlines()

	for baginfo in lines:
		data = baginfo.split(" bags contain")

		# { bag_name: [contained_bag_1, containted_bag_2, ...] }
		bdict[data[0]] = [" ".join(b.split(" ")[-3:][:2]) for b in data[1].split(",")]

	count = 0
	for bag in bdict:
		if holds_bag(bdict[bag]):
			count += 1

	print(count)


if __name__ == "__main__":
	main()
