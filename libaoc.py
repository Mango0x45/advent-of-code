from io import TextIOWrapper
from typing import Any, Callable, Iterable, Iterator, Optional, TypeVar

S = TypeVar("S")
T = TypeVar("T")
matrix = list[list[T]]


def flatten(iter: Iterable[Any]) -> Iterator[Any]:
	if hasattr(iter, "__iter__") and type(iter) != str:
		for i in iter:
			yield from flatten(i)
	else:
		yield iter


def read_int_matrix(f: TextIOWrapper) -> matrix[int]:
	return list(map(lambda l: [int(n) for n in l.strip()], f.readlines()))


def map2d(
	func: Callable[[Any], Any],
	iter: Iterable[Iterable[Any]],
	const: Optional[Callable[[T], S]] = lambda x: x,
) -> map:
	return map(lambda i: const(map(func, i)), iter)
