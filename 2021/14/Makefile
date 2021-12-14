all:
	m4 -DLOOPS=10 puzzles.py >puzzle-1.py
	m4 -DLOOPS=40 puzzles.py >puzzle-2.py
	chmod +x puzzle-[12].py

.PHONY: clean run
clean:
	rm -f puzzle-[12].py
