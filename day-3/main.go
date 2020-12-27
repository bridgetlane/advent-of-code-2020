package main

import (
	"bufio"
	"fmt"
	"os"
)

type Coords struct {
	Right int
	Down int
}

func main() {
	readInput()
}

func readInput() {
	rdVals := []Coords{
		{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2},
	}

	total := 1
	for _, val := range rdVals {
		file, err := os.Open("./input.txt")
		if err != nil {
			fmt.Println(err)
		}
		defer file.Close()

		scanner := bufio.NewScanner(file)
		total = total * traverse(scanner, val.Right, val.Down)
	}

	fmt.Println(total)
}

func traverse(scanner *bufio.Scanner, right int, down int) int {
	index := 0
	trees := 0
	i := 0
	for scanner.Scan() {
		if i == 0 || i % down != 0 {
			i++
			continue
		}

		i++

		index = index + right
		s := scanner.Text()
		if index >= len(s) {
			index = index - len(s)
		}

		if string(s[index]) == "#" {
			trees = trees + 1
		}
	}

	return trees
}