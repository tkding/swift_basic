import Foundation

// class is a reference type
// allow mutability without having to prefix thing
// allow inheritance

class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age

        // self is a reference to the current instance
        // self is not optional
        // self is not a keyword
        // self is a variable name
        // self is a constant
        // self is a reference
    }

    func increaseAge() {
        age += 1
    }
}

let foo = Person(name: "Foo", age: 10) // class can change internally
// main difference between struct and class
foo.age // 10
foo.increaseAge()
foo.age // 11

foo.age = 20 // class can change externally
let bar = foo
bar.icreaseAge() // pass by reference
bar.age // 21
foo.age // 21

// check if two instances are the same
// point to the same memory address
if foo === bar {
    print("same")
} else {
    print("not same")
}

// inheritance
class Vehicle {
    var speed: Int
    init(speed: Int) {
        self.speed = speed
    }
    func accelerate() {
        speed += 10
    }
}
class Car: Vehicle {
    var numberOfWheels: Int
    init(speed: Int, numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
        super.init(speed: speed)
    }
}

// private setter
class Person2 {
    var name: String
    private(set) var age: Int // only can be set inside the class
        // read only property

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func increaseAge() {
        age += 1
    }
}


// intializer
// convenient vs designated
// designated initializer is the main initializer
// convenient initializer is a helper initializer
class Tesla {
    let manufacturer: String = "Tesla"
    let model: String
    let year: Int

    // designated initializer
    init() {
        self.model = "Model S"
        self.year = 2016
    }

    // designated initializer
    init(model: String, year: Int) {
        self.model = model
        self.year = year
    }

    // convenient initializer
    convenience init(model: String) {
        self.init(model: model, year: 2016)
    }
}

class TeslaModelY: Tesla {
    override init() {
        super.init(model: "Model Y", year: 2017)

        // cannot call a convenient initializer from a subclass
        // self.init(model: "Model Y") // error
    }
}

let modelY = TeslaModelY()
modelY.model // Model Y
modelY.year // 2017
modelY.manufacturer // Tesla


// classes are refence type
let fooBar = person2(name: "Foo Bar", age: 10)
fooBar.age // 10
func doSomething(_ person: Person2) {
    person.increaseAge();
}
doSomething(fooBar)
fooBar.age // 11

// deinit
// notification, reactive programming
// clean memory, when mem is full
// or when function is going out of scope
class MyClass {
    init() {
        print("init")
    }
    deinit {
        print("deinit")
    }
}

let myClass = MyClass() // init
// myClass = nil // deinit