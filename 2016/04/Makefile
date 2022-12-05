.POSIX:

all:
	sed '/START PART 2/,/END PART 2/d; /START PART 1/d' puzzles.sh >puzzle-1.sh
	sed '/START PART 1/,/END PART 1/d' puzzles.sh >puzzle-2.sh
	chmod +x puzzle-[12].sh

clean:
	rm -f puzzle-[12].sh
