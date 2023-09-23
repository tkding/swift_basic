import Foundation

// extension helps to add functionality to existing types

extension Int {
    func isEven() -> Bool {
        return self % 2 == 0
    }
}
let foo = 3
foo.isEven() // false

// extension can add initializer to existing types
struct Person {
    var firstName: String
    var lastName: String
}
extension Person {
    init(fullName: String) {
        let components = fullName.components(separatedBy: " ")
        self.init(
            firstName: components.first ?? fullName,
            lastName: components.last ?? ""
        )
    }
}
let person = Person(fullName: "John Doe")
person.firstName // John
person.lastName // Doe


// extend existing types
protocol GoesVroom {
    var vroomValue: String { get }
    func vroom() -> String
}
extension GoesVroom {
    func vroom() -> String {
        "\(self.vroomValue) \(self.vroomValue)"
    }
}
struct Car {
    let manufacturer: String
    let model: String
}
let modelX = Car(manufacturer: "Tesla", model: "Model X")
extension Car: GoesVroom {
    var vroomValue: String {
        "Vroom"
    }
}
modelX.vroom() // Vroom Vroom

// adds convenience initializer
class MyDouble {
    let value: Double
    init(value: Double) {
        self.value = value
    }
}
extension MyDouble {
    convenience init(value: Int) {
        self.init(value: Double(value))
    }
    convenience init() {
        self.init(value: 0)
    }
}
let myDouble = MyDouble()
myDouble.value // 0.0

// can extension existing protocol
extension GoesVroom {
    func vroomVroom() -> String {
        "\(self.vroomValue) \(self.vroomValue) \(self.vroomValue)"
    }
}
modelX.vroomVroom() // Vroom Vroom Vroom

