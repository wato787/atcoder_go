package main

import (
	"bufio"
	"os"
	"strconv"
)

var (
	sc = bufio.NewScanner(os.Stdin)
	wr = bufio.NewWriter(os.Stdout)
)

func scanInt() int {
	sc.Scan()
	i, _ := strconv.Atoi(sc.Text())
	return i
}

func scanInts(n int) []int {
	a := make([]int, n)
	for i := 0; i < n; i++ {
		a[i] = scanInt()
	}
	return a
}


func scanString() string {
	sc.Scan()
	return sc.Text()
}

func scanStrings(n int) []string {
	s := make([]string, n)
	for i := 0; i < n; i++ {
		s[i] = scanString()
	}
	return s
}


func printInts(a []int) {
	for i, v := range a {
		if i > 0 {
			wr.WriteByte(' ')
		}
		wr.WriteString(strconv.Itoa(v))
	}
	wr.WriteByte('\n')
}

func println(a ...interface{}) {
	for i, v := range a {
		if i > 0 {
			wr.WriteByte(' ')
		}
		switch v := v.(type) {
		case int:
			wr.WriteString(strconv.Itoa(v))
		case string:
			wr.WriteString(v)
		case []int:
			printInts(v)
		}
	}
	wr.WriteByte('\n')
}

func isOdd(n int) bool {
	return n % 2 != 0 
}

func isEven(n int) bool {
	return n % 2 == 0 
}

func max(n []int) int {
    if len(n) == 0 {
        return -9999999 // または適切なエラー処理
    }
    max := n[0]
    for _, s := range n {
        if max < s {
            max = s
        }
    }
    return max
}


func min(n []int) int {
	max := -9999999
for _, s := range n {
	if max > s {
		max = s
	}
}
return max
}

func init() {
	sc.Split(bufio.ScanWords)
	sc.Buffer(make([]byte, 1024), 1<<20) // 1MB
}

// グリッドを90度右に回転する関数
func rotateGrid(grid []string, n int) []string {
	rotated := make([]string, n)
	for i := 0; i < n; i++ {
		var sb []byte = make([]byte, n)
		for j := 0; j < n; j++ {
			sb[j] = grid[n-1-j][i]
		}
		rotated[i] = string(sb)
	}
	return rotated
}

// 2つのグリッド間の異なるマスの数を数える関数
func countDifferences(grid1 []string, grid2 []string, n int) int {
	diff := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if grid1[i][j] != grid2[i][j] {
				diff++
			}
		}
	}
	return diff
}

func main() {
	defer wr.Flush()
	
	n := scanInt()
	
	// グリッドSを読み込む
	gridS := scanStrings(n)
	
	// グリッドTを読み込む
	gridT := scanStrings(n)
	
	// 最小操作回数を計算
	minOperations := n * n // 最大でもN*N回の色変更で一致させられる
	
	// 4つの回転状態をチェック
	currGrid := make([]string, n)
	copy(currGrid, gridS)
	
	for rot := 0; rot < 4; rot++ {
		// 回転状態rotでの色変更回数
		colorChanges := countDifferences(currGrid, gridT, n)
		
		// 回転回数 + 色変更回数
		totalOps := rot + colorChanges
		
		// 最小操作回数を更新
		if totalOps < minOperations {
			minOperations = totalOps
		}
		
		// 次の回転状態へ
		if rot < 3 { // 3回目の回転後は計算不要
			currGrid = rotateGrid(currGrid, n)
		}
	}
	
	println(minOperations)
}