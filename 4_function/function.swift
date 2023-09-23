import Foundation

func noArgumentsAndNoReturnValue() {
    print("This function has no arguments and no return value.")
}
noArgumentsAndNoReturnValue()

// 1 parameter
func plusTwo(value: Int) {
    let newValue = value + 2
}
plusTwo(value: 5)

// with retur value
func plusTwoReturn(value: Int) -> Int {
    let newValue = value + 2
    return newValue
}
plusTwoReturn(value: 5)

// multiple parameters
func plusTwoMultiple(value: Int, value2: Int) -> Int {
    let newValue = value + value2
    return newValue
}
let result = plusTwoMultiple(value: 5, value2: 10)

// every argument can have two label
// external and internal
func customMinus(
    _ value: Int,
    _ value2: Int
) -> Int {
    let newValue = value - value2
    return newValue
}
customMinus(10, 5)

// discardable result
// if the return value is not used, the compiler will not show warning
@discardableResult
func customMinus2(
    _ value: Int,
    _ value2: Int
) -> Int {
    let newValue = value - value2
    return newValue
}
customMinus2(10, 5)

// contain own function
func doSomethingComplicated(
    with value: Int
 ) -> Int {
    // this function is only available in this function
    func mainLogic(value: Int) -> Int {
        return value + 2
    }

    return mainLogic(value: value + 3);
}
print(doSomethingComplicated(with: 5)) // 10

// functions can have default values
func getFullName(
    firstName: String = "John",
    lastName: String = "Doe"
) -> String {
    return firstName + " " + lastName
}
print(getFullName()) // John Doe
print(getFullName(firstName: "Jane")) // Jane Doe
print(getFullName(lastName: "Doe")) // John Doe
print(getFullName(firstName: "Jane", lastName: "Doe")) // Jane Doe



