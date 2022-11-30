.POSIX:

all:
	sed '/START PART 2/,/END PART 2/d' puzzles.py >puzzle-1.py
	sed '/START PART 1/,/END PART 1/d' puzzles.py >puzzle-2.py
	chmod +x puzzle-[12].py

clean:
	rm -f puzzle-[12].py
