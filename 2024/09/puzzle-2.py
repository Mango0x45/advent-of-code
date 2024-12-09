#!/usr/bin/python3


import bisect
import collections
import operator


Block = collections.namedtuple("Block", ["pos", "size"])
File = collections.namedtuple("File", ["id", "pos", "size"])


def first_free_block(free: list[list[int]], file: File) -> Block | None:
	size = None
	pos = file.pos
	for i, xs in enumerate(free[file.size:], file.size):
		if len(xs) > 0 and xs[0] < pos:
			size = i
			pos = xs[0]
	return size and Block(pos, size)


def main() -> None:
	with open("input") as f:
		s = f.read()

	pos = 0
	files = []
	free = [[] for _ in range(10)]
	for i, ch in enumerate(s):
		size = int(ch)
		if (i & 1) == 0:
			files.append(File(i // 2, pos, size))
		elif size != 0:
			free[size].append(pos)
		pos += size

	posgetr = operator.attrgetter("pos")

	i = len(files) - 1
	while i >= 0:
		if blk := first_free_block(free, files[i]):
			f = files.pop(i)
			free[blk.size].pop(0)
			bisect.insort(files, File(f.id, blk.pos, f.size), key=posgetr)
			if blk.size != f.size:
				bisect.insort(free[blk.size - f.size], blk.pos + f.size)
		else:
			i -= 1

	n = 0
	for f in files:
		for i in range(f.size):
			n += f.id * (f.pos + i)
	print(n)


if __name__ == "__main__":
	main()