#!/usr/bin/python3

def main() -> None:
	with open("input", "r") as f:
		prog = [
			int(x) for x in (
				next(l for l in f.readlines() if l.startswith("Program"))
				.split(':' )[1]
				.split(',')
			)
		][::-1]
	print(search(prog))


def step(a: int) -> int:
	b = (a & 7) ^ 2
	return (a>>b ^ b ^ 7) & 7


def search(prog: list[int], a: int = 0) -> int | None:
	if len(prog) == 0:
		return a
	for i in range(0b111 + 1):
		n = a<<3 | i
		if (
			step(n) == prog[0]
			and (b := search(prog[1:], n)) is not None
		):
			return b


if __name__ == "__main__":
	main()