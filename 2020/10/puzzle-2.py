#!/usr/bin/env python3

adaptors: list[str]


def combos(i: int, counts: dict[int, dict[int, int]] = {}) -> int:
	if i == len(adaptors) - 1:
		return 1
	if i in counts:
		return counts[i]

	counts[i] = sum(
		combos(j, counts) if adaptors[j] - adaptors[i] <= 3 else 0
		for j in range(i + 1, len(adaptors))
	)
	return counts[i]


def main() -> None:
	global adaptors
	with open("input", "r", encoding="utf-8") as f:
		adaptors = list(map(int, f.readlines()))

	adaptors.append(0)
	adaptors.sort()
	adaptors.append(adaptors[-1] + 3)

	print(combos(0))


if __name__ == "__main__":
	main()
