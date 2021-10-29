#!/usr/bin/env python3


bdict: dict[str, list[str]] = {}

# Recursively find the number of sub-bags in a bag
def total_bags(innerbags: list[dict[int, str]]) -> int:
	if innerbags[0]["name"] == "no other":
		return 0

	return sum([bag["count"] + bag["count"] * total_bags(bdict[bag["name"]]) for bag in innerbags])


def main() -> None:
	with open("input", "r") as f:
		lines = f.readlines()

	for baginfo in lines:
		data = baginfo.split(" bags contain")

		# { bag_name: [{ count: n, name: bag_name_ }, ...] }
		bdict[data[0]] = []
		for b in data[1].split(","):
			bdict[data[0]].append(
				{
					"count": int(b.replace("no", "0").split(" ")[1]),
					"name": " ".join(b.split(" ")[-3:][:2]),
				}
			)

	print(total_bags(bdict["shiny gold"]))


if __name__ == "__main__":
	main()
