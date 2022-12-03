#!/usr/bin/python3

def cut(s: str) -> (str, str):
	n = len(s) // 2
	return s[:n], s[n:]


def main() -> None:
	with open("input", "r") as f:
		data = f.readlines()

	acc = 0
	for line in data:
		car, cdr = cut(line)
		for c in car:
			if cdr.find(c) != -1:
				if "a" <= c <= "z":
					acc += ord(c) - ord("a") + 1
				else:
					acc += ord(c) - ord("A") + 27
				break

	print(acc)


if __name__ == "__main__":
	main()
