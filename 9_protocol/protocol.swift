import Foundation

// protocol is like an interface in Java
// only the skeleton, no implementation

protocol CanBreath {
    func breath()
}

class Person: CanBreath {
    func breath() {
        print("breathing")
    }
}

let foo = Person()
foo.breath() // breathing

// struct allow implementation from protocol
// no inheritance
struct Animal: CanBreath {
    func breath() {
        print("Animal breathing")
    }
}
let bar = Animal()
bar.breath() // Animal breathing


// protocol can have implementation
protocol CanJump {
    func jump()
}

extension CanJump {
    func jump() {
        print("jumping")
    }
}

// cannot create instance from protocol
// let foo = CanJump() // error

struct Cat: CanJump {
    // if leave it, will use the default implementation
    func jump() {
        print("Cat jumping")
    }
}


// protocol can have properties
protocol HasName {
    var name: String { get }
    var age: Int { get set }
    func describe() -> String
    mutating func increaseAge() // list here to make it clear
}
extension HasName {
    func describe() -> String {
        return "your name is \(name)"
    }
    mutating func increaseAge() {
        age += 1
    }
}

struct Dog: HasName {
    let name: String
    var age: Int
}

var dog = Dog(name: "Dog", age: 10)
dog.name // Dog
dog.age // 10
dog.age = 20 // can change bc we use var for struct
dog.describe() // your name is Dog
dog.increaseAge()
dog.age // 21


// protocol can be used as a conform
// using "is"
func describe(obj: Any){
    if obj is HasName {
        print("obj has name")
    }
}
describe(obj: dog) // obj has name

// as? as! is also available
// as? return optional
// as! return the type
func describe2(obj: Any){
    if let obj = obj as? HasName {
        obj.describe() // can use bc we know it's HasName
        // rmb since Dog is a struct, the value is passed by value
        // the changes will not be reflected
        print("obj has name \(obj.name)")
    }
}

