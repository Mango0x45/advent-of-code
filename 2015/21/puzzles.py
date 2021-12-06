#!/usr/bin/env python3


import itertools
import math

SHOP = [
	("Weapon", 8, 4, 0),
	("Weapon", 10, 5, 0),
	("Weapon", 25, 6, 0),
	("Weapon", 40, 7, 0),
	("Weapon", 74, 8, 0),
	("Armor", 0, 0, 0),
	("Armor", 13, 0, 1),
	("Armor", 31, 0, 2),
	("Armor", 53, 0, 3),
	("Armor", 75, 0, 4),
	("Armor", 102, 0, 5),
	("Ring", 0, 0, 0),
	("Ring", 0, 0, 0),
	("Ring", 25, 1, 0),
	("Ring", 50, 2, 0),
	("Ring", 100, 3, 0),
	("Ring", 20, 0, 1),
	("Ring", 40, 0, 2),
	("Ring", 80, 0, 3),
]


def wins(d: int, hp: int) -> bool:
	turns = hp / d
	if turns > int(turns):
		turns = math.ceil(turns)

	return (turns - 1) * d < 100


def valid(e: tuple[tuple[str, int, int, int], ...]) -> bool:
	w = a = r = 0
	for i in e:
		match i[0]:
			case "Weapon":
				w += 1
			case "Armor":
				a += 1
			case "Ring":
				r += 1
	return (w == 1) and (a <= 1) and (r <= 2)


def main() -> None:
	with open("input", "r", encoding="utf-8") as f:
		b_health, b_damage, b_armor = f.readlines()
	b_health = int(b_health.strip().split(": ")[1])
	b_damage = int(b_damage.strip().split(": ")[1])
	b_armor = int(b_armor.strip().split(": ")[1])

	# START PART 1
	min_cost = float('inf')
	# END PART 1 START PART 2
	max_cost = 0
	# END PART 2

	for combs in [itertools.combinations(SHOP, i) for i in range(1, 5)]:
		for comb in list(filter(valid, combs)):
			cost = sum(x[1] for x in comb)
			damage = sum(x[2] for x in comb)
			armor = sum(x[3] for x in comb)
			delta = (damage - b_armor) - (b_damage - armor)

			# START PART 1
			if (delta > 0) or ((delta == 0) and wins(damage - b_armor, b_health)):
				min_cost = min(cost, min_cost)
			# END PART 1 START PART 2
			if (delta < 0) or ((delta == 0) and not wins(damage - b_armor, b_health)):
				max_cost = max(cost, max_cost)
			# END PART 2

	# START PART 1
	print(min_cost)
	# END PART 1 START PART 2
	print(max_cost)
	# END PART 2


if __name__ == "__main__":
	main()
