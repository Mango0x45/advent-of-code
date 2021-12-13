all:
	sed '/START PART 2/,/END PART 2/d' puzzles.awk >puzzle-1.awk
	sed '/START PART 1/,/END PART 1/d' puzzles.awk >puzzle-2.awk
	chmod +x puzzle-[12].awk

.PHONY: clean run
clean:
	rm -f puzzle-[12].awk
