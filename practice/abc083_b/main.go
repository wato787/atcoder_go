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

func init() {
	sc.Split(bufio.ScanWords)
	sc.Buffer(make([]byte, 1024), 1<<20) // 1MB
}

func main() {
	defer wr.Flush()
	
	// ここに解答コードを書く
	n := scanInt()
	a := scanInt()
	b := scanInt()

// N 以下の整数のうち、
// 10 進法での各桁の和が 
// A 以上 
// B 以下であるものの総和を出力せよ。

    sum := 0
    
    // 1からn以下をループ
    for i := 1; i <= n; i++ {
        // 各桁の和を計算
        ds := digitSum(i)
        
        // 各桁の和がA以上B以下かチェック
        if ds >= a && ds <= b {
            sum += i  // 条件を満たす場合、合計に追加
        }
    }
    
    println(sum)
}

// 数値の各桁の和を計算する関数
func digitSum(num int) int {
    sum := 0
    for num > 0 {
        sum += num % 10  // 一番右の桁を取得
        num /= 10        // 右の桁を削除
    }
    return sum
}