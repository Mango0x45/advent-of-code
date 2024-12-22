#!/usr/bin/python3

import collections
from typing import Deque, Iterable


type Diff = tuple[int, int, int, int]


def main() -> None:
	with open("input", "r") as f:
		xs = map(int, f.readlines())

	# START PART 1
	print(sum(map(takelast, map(secrets, xs))))
	# END PART 1 START PART 2
	sums = collections.defaultdict(int)
	for x in xs:
		seen: set[Diff] = set()
		dq: Deque[int] = collections.deque(maxlen=4)

		gen = map(lastdigit, secrets(x))
		last = next(gen)

		for _ in range(3):
			n = next(gen)
			dq.append(n - last)
			last = n

		for n in gen:
			dq.append(n - last)
			if (t := tuple(dq)) not in seen:
				seen.add(t)
				sums[t] += n
			last = n
			dq.popleft()

	print(max(sums.values()))
	# END PART 2


def secrets(n: int) -> int:
	for _ in range(2000):
		n = (n ^ n<<6)	& 0xFFFFFF
		n = (n ^ n>>5)	& 0xFFFFFF
		n = (n ^ n<<11) & 0xFFFFFF
		yield n


def lastdigit(n: int) -> int:
	return n % 10


def takelast[T](xs: Iterable[T]) -> T:
	*_, x = xs
	return x


if __name__ == "__main__":
	main()
