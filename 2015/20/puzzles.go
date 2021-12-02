package main

import (
	"fmt"
	"math"
	"os"
)

func calc(n int) int {
	acc := 0
	s := math.Sqrt(float64(n))

	if s == math.Trunc(s) {
		acc += int(s)
	} else {
		s = math.Ceil(s)
	}

	for i := 1; i < int(s); i++ {
		if n%i == 0 {
			/* START PART 2 */
			ndi := n / i
			if ndi <= 50 {
				acc += i + ndi
			} else if i <= 50 {
				acc += ndi
			}
			/* END PART 2 START PART 1 */
			acc += i + n/i
			/* END PART 1 */
		}
	}

	return acc
}

func main() {
	file, err := os.Open("input")
	if err != nil {
		fmt.Fprintf(os.Stderr, "%s: %s\n", os.Args[0], err)
		os.Exit(1)
	}

	var n int
	fmt.Fscanf(file, "%d", &n)
	file.Close()
	/* START PART 2 */
	sn := n / 11
	/* END PART 2 START PART 1 */
	sn := n / 10
	/* END PART 1 */

	for i := 1; i <= n; i++ {
		if calc(i) >= sn {
			fmt.Println(i)
			break
		}
	}
}
