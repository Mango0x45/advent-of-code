#!/usr/bin/env python3


bdict: dict[str, list[str]] = {}

# Recursively check if a bag can hold a shiny gold bag
def holds_bag(innerbags: list[str]) -> bool:
	if "no other" in innerbags:
		return False
	elif "shiny gold" in innerbags:
		return True
	return any(holds_bag(bdict[subbag]) for subbag in innerbags)


def main() -> None:
	global bdict
	with open("input", "r", encoding="utf-8") as f:
		lines = f.readlines()

	for baginfo in lines:
		data = baginfo.split(" bags contain")

		# { bag_name: [contained_bag_1, containted_bag_2, ...] }
		bdict[data[0]] = [" ".join(b.split(" ")[-3:][:2]) for b in data[1].split(",")]

	print(sum(holds_bag(bdict[bag]) for bag in bdict))


if __name__ == "__main__":
	main()
