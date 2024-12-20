.POSIX:

all:
	sed -e '/START PART 2/,/END PART 2/d'                                       \
		-e '1aPUZZLE_PART = 1'                                                  \
		puzzles.py >puzzle-1.py
	sed -e '/START PART 1/,/END PART 1/d'                                       \
		-e '1aPUZZLE_PART = 2'                                                  \
		puzzles.py >puzzle-2.py
	chmod +x puzzle-[12].py

clean:
	rm -f puzzle-[12].py