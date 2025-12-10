#!/usr/bin/python3

import dataclasses
import functools
import itertools
import operator
from typing import Self


@dataclasses.dataclass
class Machine:
	target: int
	buttons: list[int]

	@classmethod
	def from_record(cls, s: str) -> Self:
		buttons: list[int] = []
		for token in s.split(' '):
			match token[0]:
				case '[':
					token = token.translate({
						ord('.'): '0',
						ord('#'): '1',
					})
					target = int(token[len(token) - 2:0:-1], base=2)
				case '(':
					n = 0
					for x in map(int, token[1:-1].split(',')):
						n |= 1 << x
					buttons.append(n)
		return cls(target, buttons)


def main() -> None:
	with open('input', 'r') as f:
		xs = [Machine.from_record(x) for x in f.readlines()]
	print(sum(map(fewest_clicks, xs)))


def fewest_clicks(mach: Machine) -> int:
	for i in itertools.count(start=1):
		for comb in itertools.combinations(mach.buttons, i):
			if functools.reduce(operator.xor, comb) == mach.target:
				return i
	# NOTREACHED


if __name__ == '__main__':
	main()
