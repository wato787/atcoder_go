package main

import (
    "bufio"
    "fmt"
    "os"
    "strconv"
)

var sc = bufio.NewScanner(os.Stdin)

func nextInt() int {
    sc.Scan()
    i, _ := strconv.Atoi(sc.Text())
    return i
}

func nextString() string {
    sc.Scan()
    return sc.Text()
}

func init() {
    sc.Split(bufio.ScanWords)
}

func main() {
    // ここに解答コードを書く
}