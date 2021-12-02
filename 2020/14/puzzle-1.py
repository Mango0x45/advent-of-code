#!/usr/bin/env python3


def bitmask(mask: str, num: int) -> int:
	binary = bin(num)[2:]
	binary = "0" * (36 - len(binary)) + binary
	res = ""

	for i in range(len(binary)):
		if binary[i] == "1" and mask[i] == "0":
			res += "0"
		elif binary[i] == "0" and mask[i] == "1":
			res += "1"
		else:
			res += binary[i]

	return int(res, 2)


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		lines = f.read().splitlines()

	mem: dict[str, int] = {}
	mask = ""
	for line in lines:
		match line.split(" "):
			case ["mask", _, mask]:
				mask = mask
			case [addr, _, val]:
				mem[addr[4:-1]] = bitmask(mask, int(val))

	print(sum(mem.values()))


if __name__ == "__main__":
	main()
