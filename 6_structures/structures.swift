import Foundation

// struct is a value type
// struc has implict initializer
struct Person {
    var name: String
    var age: Int
}
// instance of struct
let foo = Person(name: "Foo", age: 10)
// accesssing
foo.name
foo.age

struct CommodoreComputer {
    let name: String
    let manufacturer: String = "Commodore"

    // custom initializer
    // init(name: String) {
    //     self.name = name
    //     self.manufacturer = "Commodore"
    // }
}
let commodore64 = CommodoreComputer(name: "Commodore 64")


// computed property
struct Rectangle {
    var width: Int
    var height: Int
    var area: Int {
        return width * height
    }
} 
// or
struct Person2{
    let firstName: String
    let lastName: String
    // must use var
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
let person = Person2(firstName: "Foo", lastName: "Bar")
person.fullName // Foo Bar

// mutating method
struct Car {
    var speed: Int
    // generally we don't mutate struct
    mutating func accelerate() {
        speed += 10
    }
}
let immCar = Car(speed: 10)
// immCar.accelerate() // error

var mutCar = Car(speed: 10)
mutCar.accelerate() // 20 
let copy = mutCar // copy is a copy of mutCar
                    // pass by value

/// swift struct cannot inherit from other struct
/// no subclassing


// custom logic while copying over
struct Bike{
    let manufacturer: String
    let speed: Int
    func copy(speed: Int) -> Bike {
        return Bike(manufacturer: self.manufacturer, speed: speed)
    }
}

let bike1 = Bike(manufacturer: "Giant", speed: 10)
let bike2 = bike1.copy(speed: 20)