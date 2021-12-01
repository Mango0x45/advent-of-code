all:
	for ext in py sh; do \
		m4 -D DELTA=1 puzzles.$$ext >puzzle-1.$$ext; \
		m4 -D DELTA=3 puzzles.$$ext >puzzle-2.$$ext; \
	done
	chmod +x puzzle-[12].{py,sh}

.PHONY: clean
clean:
	rm -f puzzle-[12].{py,sh}
