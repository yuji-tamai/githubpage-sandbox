package main

import (
	"syscall/js"
)

// 1からp[0]までの和を計算
func addNumbers(this js.Value, p []js.Value) interface{} {
	n := p[0].Int()
	sum := 0
	for i := 1; i <= n; i++ {
		sum += i
	}
	return sum
}

func main() {
	c := make(chan struct{}, 0)

	js.Global().Set("addNumbers", js.FuncOf(addNumbers))

	<-c
}
