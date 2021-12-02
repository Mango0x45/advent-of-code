#!/usr/bin/env python3

from functools import reduce


def chinese_remainder(n: tuple[int, ...], a: tuple[int, ...]) -> int:
	sum = 0
	prod = reduce(lambda a, b: a * b, n)
	for n_i, a_i in zip(n, a):
		p = prod // n_i
		sum += a_i * mul_inv(p, n_i) * p
	return sum % prod


def mul_inv(a: int, b: int) -> int:
	b0 = b
	x0, x1 = 0, 1
	if b == 1:
		return 1
	while a > 1:
		q = a // b
		a, b = b, a % b
		x0, x1 = x1 - q * x0, x0
	if x1 < 0:
		x1 += b0
	return x1


def main() -> None:
	with open("input", "r") as f:
		ids = tuple(map(lambda x: int(x) if x.isdigit() else x, f.readlines()[1].split(",")))

	buses = tuple(filter(lambda x: x != "x", ids))
	modres = tuple(x if (x := bus - ids.index(bus)) != bus else 0 for bus in buses)
	print(chinese_remainder(buses, modres))


if __name__ == "__main__":
	main()
