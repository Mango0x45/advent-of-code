package main

import (
	"fmt"
	"strconv"
)

func process(num string) string {
	var newnum string

	for i := 0; i < len(num); {
		c := num[i]
		j := 0
		for i < len(num) && num[i] == c {
			i++
			j++
		}
		newnum += strconv.Itoa(j)
		newnum = string(append([]byte(newnum), c))
	}

	return newnum
}

func main() {
	num := INPUT
	for i := 0; i < LOOPS; i++ {
		num = process(num)
	}
	fmt.Println(len(num))
}
