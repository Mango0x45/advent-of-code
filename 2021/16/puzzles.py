#!/usr/bin/env python3

from math import prod
from typing import NamedTuple

data: str


class Packet(NamedTuple):
	pass


class Packet(NamedTuple):
	version: int
	type: int
	value: int
	subpackets: list[Packet]

	def calculate(self) -> int:
		f = lambda p: p.calculate()

		# START PART 1
		return self.version + sum(map(f, self.subpackets))
		# END PART 1 START PART 2
		match self.type:
			case 0:
				return sum(map(f, self.subpackets))
			case 1:
				return prod(map(f, self.subpackets))
			case 2:
				return min(map(f, self.subpackets))
			case 3:
				return max(map(f, self.subpackets))
			case 4:
				return self.value
			case 5:
				return f(self.subpackets[0]) > f(self.subpackets[1])
			case 6:
				return f(self.subpackets[0]) < f(self.subpackets[1])
			case 7:
				return f(self.subpackets[0]) == f(self.subpackets[1])
		# END PART 2


def solve() -> Packet:
	global data

	v = int(data[:3], 2)
	t = int(data[3:6], 2)
	data = data[6:]

	if t == 4:
		val = ""
		while data[0] == "1":
			val += data[1:5]
			data = data[5:]
		val += data[1:5]
		data = data[5:]
		return Packet(v, t, int(val, 2), [])

	l = data[0]
	data = data[1:]

	if l == "0":
		length = int(data[:15], 2)
		data = data[15:]
		oldlen = len(data)

		subpackets = []
		while oldlen - len(data) < length:
			subpackets.append(solve())

		return Packet(v, t, 0, subpackets)

	n = int(data[:11], 2)
	data = data[11:]
	return Packet(v, t, 0, [solve() for _ in range(n)])


def main() -> None:
	global data

	with open("input", "r", encoding="utf-8") as f:
		data = "".join(bin(n)[2:].zfill(8) for n in bytes.fromhex(f.read().strip()))

	print(solve().calculate())


if __name__ == "__main__":
	main()
