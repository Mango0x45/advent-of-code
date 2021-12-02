all:
	m4 -D GROUPS=5 puzzles.py | sed '/# START PART 2/,/# END PART 2/d' >puzzle-1.py
	m4 -D GROUPS=6 puzzles.py | sed '/# START PART 1/,/# END PART 1/d' >puzzle-2.py
	chmod +x puzzle-[12].py

.PHONY: clean
clean:
	rm -f puzzle-[12].py
