#!/usr/bin/env python3

def main() -> None:
	with open("input", "r") as f:
		nums = [int(n) for n in f.readlines()]

	# START PART 2
	nums = [nums[i] + nums[i - 1] + nums[i - 2] for i in range(2, len(nums))]
	# END PART 2
	print(sum(nums[i] > nums[i - 1] for i in range(1, len(nums))))

if __name__ == "__main__":
	main()
