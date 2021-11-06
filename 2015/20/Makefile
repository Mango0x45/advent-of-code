all:
	sed '/START PART 2/,/END PART 2/d' puzzles.go >tmp1.go
	sed '/START PART 1/,/END PART 1/d' puzzles.go >tmp2.go
	go build tmp1.go
	go build tmp2.go
	mv tmp1 puzzle-1
	mv tmp2 puzzle-2
	rm -f tmp[12].go

.PHONY: clean
clean:
	rm -f puzzle-[12]
