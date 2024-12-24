#!/usr/bin/python3

import collections
from typing import Deque


def main() -> None:
	with open("input", "r") as f:
		head, tail = [s.split("\n") for s in f.read().split("\n\n")]
	wires: dict[str, int] = {}
	for line in head:
		wire, val = line.split(": ")
		wires[wire] = int(val)
	todo: Deque[list[str]] = collections.deque()
	for line in tail:
		parts = line.split()
		parts.pop(3)            # Pop ‘->’
		todo.append(parts)

	while todo:
		eqn = todo[0]
		if not (eqn[0] in wires and eqn[2] in wires):
			todo.rotate(-1)
			continue
		else:
			todo.popleft()
		lhs = wires[eqn[0]]
		rhs = wires[eqn[2]]
		match eqn[1]:
			case 'AND':
				x = lhs & rhs
			case 'OR':
				x = lhs | rhs
			case 'XOR':
				x = lhs ^ rhs
		wires[eqn[3]] = x

	n = 0
	ends = ((k, v) for k, v in wires.items() if k[0] == 'z')
	for k, v in sorted(ends, reverse=True):
		n = n<<1 | v
	print(n)


if __name__ == "__main__":
	main()