#!/usr/bin/python3

import itertools


def main() -> None:
    with open('input', 'r') as f:
        xs = f.readlines()
    print(next(
        x for x in
        itertools.starmap(common, itertools.combinations(xs, 2))
        if x is not None
    ), end='')


def common(x: str, y: str) -> str | None:
    it = (i for i, (a, b) in enumerate(zip(x, y)) if a != b)
    i = next(it)
    try:
        next(it)
    except StopIteration:
        return x[:i] + x[i+1:]


if __name__ == '__main__':
    main()
