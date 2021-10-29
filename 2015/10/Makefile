all:
	m4 -D INPUT=\"$$(cat input)\" -D LOOPS=40 -U len puzzles.go >tmp1.go
	m4 -D INPUT=\"$$(cat input)\" -D LOOPS=50 -U len puzzles.go >tmp2.go
	go build tmp1.go
	go build tmp2.go
	mv tmp1 puzzle-1
	mv tmp2 puzzle-2
	rm tmp[12].go

.PHONY: clean
clean:
	rm -f puzzle-[12] tmp[12].go
