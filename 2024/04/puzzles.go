package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func main() {
	f, err := os.Open("input")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	sc := bufio.NewScanner(f)
	fmt.Println(xmasCnt(parseInput(sc)))
}

func parseInput(sc *bufio.Scanner) [][]rune {
	var data [][]rune
	for sc.Scan() {
		row := make([]rune, 0, 140)
		for _, ch := range sc.Text() {
			row = append(row, ch)
		}
		data = append(data, row)
	}
	return data
}

// START PART 1

func xmasCnt(data [][]rune) int {
	cnt := 0
	for i := range data {
		for j := range data[i] {
			coords := [...][8]int{
				{i + 0, j + 0, i + 1, j + 0, i + 2, j + 0, i + 3, j + 0}, // Vertical;   top-down
				{i + 0, j + 0, i - 1, j + 0, i - 2, j + 0, i - 3, j + 0}, // Vertical;   down-top
				{i + 0, j + 0, i + 0, j + 1, i + 0, j + 2, i + 0, j + 3}, // Horizontal; left-right
				{i + 0, j + 0, i + 0, j - 1, i + 0, j - 2, i + 0, j - 3}, // Horizontal; left-right
				{i + 0, j + 0, i - 1, j + 1, i - 2, j + 2, i - 3, j + 3}, // Diagonal;   bl-tr
				{i + 0, j + 0, i + 1, j + 1, i + 2, j + 2, i + 3, j + 3}, // Diagonal;   tl-br
				{i + 0, j + 0, i + 1, j - 1, i + 2, j - 2, i + 3, j - 3}, // Diagonal;   tr-bl
				{i + 0, j + 0, i - 1, j - 1, i - 2, j - 2, i - 3, j - 3}, // Diagonal;   br-tl
			}
			for _, x := range coords {
				if x[0] >= 0 && x[0] < len(data) &&
					x[2] >= 0 && x[2] < len(data) &&
					x[4] >= 0 && x[4] < len(data) &&
					x[6] >= 0 && x[6] < len(data) &&
					x[1] >= 0 && x[1] < len(data[0]) &&
					x[3] >= 0 && x[3] < len(data[0]) &&
					x[5] >= 0 && x[5] < len(data[0]) &&
					x[7] >= 0 && x[7] < len(data[0]) &&
					data[x[0]][x[1]] == 'X' &&
					data[x[2]][x[3]] == 'M' &&
					data[x[4]][x[5]] == 'A' &&
					data[x[6]][x[7]] == 'S' {
					cnt++
				}
			}
		}
	}
	return cnt
}

// END PART 1 START PART 2

func xmasCnt(data [][]rune) int {
	cnt := 0
	for i := range data {
		for j := range data[i] {
			if data[i][j] != 'A' ||
				i == 0 || i == len(data)-1 ||
				j == 0 || j == len(data[0])-1 {
				continue
			}
			x1 := [...]rune{data[i-1][j-1], data[i+1][j+1]}
			x2 := [...]rune{data[i+1][j-1], data[i-1][j+1]}
			if ((x1[0] == 'S' && x1[1] == 'M') || (x1[0] == 'M' && x1[1] == 'S')) &&
				((x2[0] == 'S' && x2[1] == 'M') || (x2[0] == 'M' && x2[1] == 'S')) {
				cnt++
			}
		}
	}
	return cnt
}

// END PART 2
