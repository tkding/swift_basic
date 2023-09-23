import Foundation

let myAge = 22
let yourAge = 20

if myAge > yourAge {
    print("I'm older than you")
} else if myAge < yourAge {
    print("I'm younger than you")
} else {
    print("We're the same age")
}

// 3 types of operators
// unary : 1 value, binary : 2 values
// unary prefix
// unary postfix
// binary infix

// unary prefix
let foo = !true // not

// unary postfix
let name = Optional("John")
type(of: name) // Optional<String>.Type
let unwrappedName = name! // force unwrap 
type(of: unwrappedName) // String.Type

// binary infix
let myMotherAge = myAge + 20 // plus
let doubleMyAge = myAge * 2 // multiply
let names = "Foo" + " " + "Bar" // concatenate

// ternary
let isMyAgeGreaterThanYourAge = myAge > yourAge ? true : false
let age = 30
let message = age > 20 ? "You're old" : "You're young"


