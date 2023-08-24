package main

import (
    "fmt"
    "time"
)

type MyStruct struct {
    ID      string
    Val     float64
    Created time.Time
}

// Define methods on structs
func (obj MyStruct) Lifetime() time.Duration {
    return time.Now().UTC().Sub(obj.Created)
}

func main() {
    obj1 := MyStruct{"Derp", 42.0, time.Now()}
    fmt.Println(obj1)

    ID1 := obj1.ID // access single values with dot notation
    fmt.Printf("obj1 ID: %s\n", ID1) // verbose output

    // alternative declaration omitting values
    obj2 := MyStruct{
        ID: "Derp",
        Val: 42.0,
    }
    fmt.Printf("%#v\n", obj2) // verbose output

    // declaration without any assigment, only defaults
    var obj3 MyStruct
    fmt.Printf("%#v\n", obj3) // verbose output

    fmt.Println("Object obj1 lived for ", obj1.Lifetime(), "\n")
}
