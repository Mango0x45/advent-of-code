def main() -> None:
	acc = 0
	with open("input", "r") as f:
		while line := f.readline():
			l, r = map(str.split, line.split('|'))
			l = set(filter(str.isdigit, l))
			r = set(filter(str.isdigit, r))
			if s := l & r:
				acc += 1 << (len(s) - 1)
	print(acc)


if __name__ == "__main__":
	main()