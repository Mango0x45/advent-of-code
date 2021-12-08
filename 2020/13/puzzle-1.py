#!/usr/bin/env python3


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		time = int(f.readline())
		ids = sorted(map(int, f.readline().replace(",x", "").split(",")))

	min = -1
	x = 0
	for bus in ids:
		res = (time + ids[0]) % bus
		if min < res < ids[0]:
			min = res
			x = bus

	for i in range(time, time + ids[0]):
		if i % x == 0:
			print((i - time) * x)
			break


if __name__ == "__main__":
	main()
