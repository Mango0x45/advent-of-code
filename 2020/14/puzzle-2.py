#!/usr/bin/env python3


def bitmask(mask: str, num: int) -> tuple[int, ...]:
	binary = bin(num)[2:]
	binary = binary.zfill(36)
	res = ""

	for i in range(len(binary)):
		if mask[i] == "0":
			res += binary[i]
		else:
			res += mask[i]

	n = res.count("X")
	combos = tuple(bin(i)[2:].zfill(n) for i in range(2 << n - 1))

	acc: list[str] = []
	for combo in combos:
		temp = res
		for i in range(n):
			temp = temp.replace("X", combo[i], 1)
		acc.append(temp)

	return tuple(int(x, 2) for x in acc)


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		lines = f.readlines()

	mem: dict[str, int] = {}
	mask = ""
	for line in lines:
		match line.split(" "):
			case ["mask", _, mask]:
				mask = mask
			case [addr, _, val]:
				address = addr[4:-1]
				addresses = bitmask(mask, int(address))
				for a in addresses:
					mem[a] = int(val)

	print(sum(mem.values()))


if __name__ == "__main__":
	main()
