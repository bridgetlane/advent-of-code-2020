package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
)

func main() {
	in := readInput()

	loc := 0
	loc2 := 0
	for loc < len(in) {
		loc2 = loc + 1
		for loc2 < len(in) {
			if a, b, c, ok := findSum(in, in[loc], in[loc2]); ok {
				fmt.Println(a*b*c)
				break
			}

			loc2 = loc2 + 1
		}


		loc = loc + 1
	}
}

func findSum(in []int, a int, b int) (int, int, int, bool) {
	if len(in) == 0 {
		return 0, 0, 0, false
	}

	if len(in) == 1 {

	}

	loc := len(in)/2
	sum := a + b + in[loc]
	if sum == 2020 {
		return a, b, in[loc], true
	}

	if sum > 2020 && loc != 0 {
		if a, b, c, ok := findSum(in[0:loc-1], a, b); ok {
			return a, b, c, true
		}
	}

	if sum < 2020 {
		if a, b, c, ok := findSum(in[loc+1:len(in)], a, b); ok {
			return a, b, c, true
		}
	}

	return 0, 0, 0, false
}

func readInput() []int {
	file, err := os.Open("./input.txt")
	if err != nil {
		fmt.Println(err)
	}
	defer file.Close()

	var in []int

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		n, err := strconv.Atoi(scanner.Text())
		if err != nil {
			fmt.Println(err)
		}

		in = append(in, n)
	}

	if err := scanner.Err(); err != nil {
		fmt.Println(err)
	}

	sort.Ints(in)
	return in
}
