def main() -> None:
	with open("input", "r") as f:
		lines = f.readlines()
	xs = [1] * len(lines)
	for i, line in enumerate(lines):
		l, r = map(str.split, line.split('|'))
		l = set(filter(str.isdigit, l))
		r = set(filter(str.isdigit, r))
		n = len(l & r)
		for j in range(n):
			xs[i + j + 1] += xs[i]
	print(sum(xs))


if __name__ == "__main__":
	main()