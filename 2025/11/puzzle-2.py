#!/usr/bin/python3

import functools


paths: dict[str, list[str]] = {}

def main() -> None:
	with open('input', 'r') as f:
		for line in f.readlines():
			x, *xs = line.split()
			paths[x[:-1]] = xs

	print(npaths('svr', 'out'))


@functools.cache
def npaths(
	src: str,
	dst: str,
	dacp: bool = False,
	fftp: bool = False,
) -> bool | int:
	return (
		dacp and fftp
		if src == dst else
		sum(npaths(
			nsrc,
			dst,
			dacp or src == 'dac',
			fftp or src == 'fft',
		) for nsrc in paths[src])
	)


if __name__ == '__main__':
	main()
