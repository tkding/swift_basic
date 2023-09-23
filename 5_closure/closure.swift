import Foundation

// closure is a function without name
// inline function


// func add(
//     _ value: Int,
//     _ value2: Int
// ) -> Int {
//     return value + value2
// }
// closure
// { (parameters) -> return type in
// inline function
let add: (Int, Int) -> Int = { (value: Int, value2: Int) -> Int in
    return value + value2
}
add(10, 5) // 15

// passing a function to another function
func customAdd(
    _ value: Int,
    _ value2: Int,
    using add: (Int, Int) -> Int
) -> Int {
    return add(value, value2)
}
customAdd(10, 5, using: add) // 15
// or
customAdd(10, 5) {
    (value: Int, value2: Int) -> Int in
    return value + value2
} // 15
// or
customAdd(10, 5) { $0 + $1 } // 15

let ages = [10, 20, 30, 40, 50]
ages.sorted(by: { (value: Int, value2: Int) -> Bool in
    return value < value2
})
// or
ages.sorted(by: <)
