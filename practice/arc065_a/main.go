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

func main() {
    defer wr.Flush()
    
    // ここに解答コードを書く
    s := scanString()
    
    // 後ろから判定するため、文字列を反転する
    reversed := reverseString(s)
    
    // 判定用の単語も反転しておく
    patterns := []string{
        reverseString("dream"),
        reverseString("dreamer"),
        reverseString("erase"),
        reverseString("eraser"),
    }
    
    // 反転した文字列を先頭から調べていく
    pos := 0
    for pos < len(reversed) {
        found := false
        for _, pattern := range patterns {
            if pos+len(pattern) <= len(reversed) && reversed[pos:pos+len(pattern)] == pattern {
                // パターンが一致した場合、その分だけ進む
                pos += len(pattern)
                found = true
                break
            }
        }
        
        // どのパターンにも一致しなかった場合
        if !found {
            println("NO")
            return
        }
    }
    
    // 最後まで判定できた場合
    println("YES")
}

// 文字列を反転する関数
func reverseString(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}