#!/usr/bin/python3

def cut(s: str) -> (str, str):
	n = len(s) // 2
	return s[:n], s[n:]


def process(line: str) -> int:
	car, cdr = cut(line)
	c = set(car).intersection(cdr).pop()
	return ord(c) - ord('a') + 1 if c >= 'a' else ord(c) - ord('A') + 27

def main() -> None:
	with open("input", "r") as f:
		print(sum(process(line) for line in f.readlines()))


if __name__ == "__main__":
	main()
