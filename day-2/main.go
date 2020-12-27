package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func main() {
	readInput()
}

func readInput() []int {
	file, err := os.Open("./input.txt")
	if err != nil {
		fmt.Println(err)
	}
	defer file.Close()

	valid := 0

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		r := regexp.MustCompile(`(?P<LowerBound>^\d+)-(?P<UpperBound>\d+) (?P<RuleLetter>\w): (?P<Password>\w+)`)
		groups := r.FindStringSubmatch(line)

		lowerBound, err := strconv.Atoi(groups[1])
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}

		upperBound, err := strconv.Atoi(groups[2])
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}

		rule := groups[3]
		password := groups[4]

		matches := 0
		if string(password[lowerBound-1]) == rule {
			matches = matches + 1
		}

		if string(password[upperBound-1]) == rule {
			matches = matches + 1
		}

		if matches != 1 {
			continue
		}

		valid = valid + 1
	}

	if err := scanner.Err(); err != nil {
		fmt.Println(err)
	}

	fmt.Println(valid)

	return []int{}
}
