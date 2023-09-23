import Foundational


// error handling
// error handling is the process of responding to and recovering from error conditions in your program
// swift found out that error handling is a common requirement, so it provides a flexible mechanism for handling errors in your programs
// "throw"

struct Person {
    let firstName: String?
    let lastName: String?
    
    enum PersonError: Error {
        case firstNameMissing
        case lastNameMissing
        case bothNameMissing
    }

    func getFullName() throws -> String {
        switch (firstName, lastName) {
        case (.some(let firstName), .some(let lastName)):
            return firstName + " " + lastName
        case (.some(let firstName), .none):
            throw PersonError.lastNameMissing
        case (.none, .some(let lastName)):
            throw PersonError.firstNameMissing
        case (.none, .none):
            throw PersonError.bothNameMissing
        } 
    }
}

let foo = Person(firstName: "foo", lastName: "bar")
let bar = Person(firstName: "bar", lastName: nil)
let baz = Person(firstName: nil, lastName: "baz")
let qux = Person(firstName: nil, lastName: nil)

do {
    let fooFullName = try foo.getFullName()
} catch Person.PersonError.firstNameMissing {
    // or catch is Person.PersonError for all defined errors
    print("firstNameMissing")
} catch Person.PersonError.lastNameMissing {
    print("lastNameMissing")
} catch Person.PersonError.bothNameMissing {
    print("bothNameMissing")
} catch {
    print("Got an error = \(error)")
} 



// throwing errors in initializers
struct Car {
    let manufacturer: String

    enum CarError: Error {
        case ivalidManufacturer
    }

    init(
        manufacturer: String
    ) throws {
        if manufacturer.isEmpty {
            throw CarError.ivalidManufacturer
        }
        self.manufacturer = manufacturer
    } 
}

do {
    let myCar = try Car(manufacturer: "foo")
} catch Car.CarError.ivalidManufacturer {
    print("ivalidManufacturer")
} catch {
    print("Got an error = \(error)")
}

// optionally trying to call the function
if let yourCar = try? Car(manufacturer: "bar") {
    print("yourCar = \(yourCar)")
} else {
    print("yourCar is nil")
}

// forced trying to call the function
// don't use this (crash if error)
let thierCar = try! Car(manufacturer: "baz")


struct Dog {
    let isInjured: Bool
    let isSleeping: Bool

    enum BarkingErrors: Error {
        case sleeping
    }

    enum RunningErrors: Error {
        case injured
    }

    func bark() throws {
        if isSleeping {
            throw BarkingErrors.sleeping
        }
        print("bark")
    }

    func run() throws {
        if isInjured {
            throw RunningErrors.injured
        }
        print("run")
    }

    func barkAndRun() throws {
        try bark() // don't need to use do and catch bc we used throws
        
        do {
            try run()
        } catch {
            // do api call
        }
    }
}

// don't expect to catch multiple errors
let dog = Dog(isInjured: true, isSleeping: true)
do {
    try dog.barkAndRun()
} catch Dog.BarkingErrors.sleeping, Dog.RunningErrors.injured {
    print("sleeping or injured")
} catch {
    print("Got an error = \(error)")
}
// sleeping or injured

// rethrow
// function that takes a throwing function as an argument and returns a function that throws an error
// if this function doesn't throw an error, it will invoke other fnction that throws 
// needs to have argument that is a closure that throws
func fullName(
    firstName: String?,
    lastName: String?,
    calculator: (String?, String?) throws -> String?
) rethrows -> String? {
    try calculator(firstName, lastName)
}

enum NameError: Error {
    case firstNameMissing
    case lastNameMissing
}

func + (
    firstName: String?,
    lastName: String?
) throws -> String { // promotion, higher order function
    guard let firstName,
        !firstName.isEmpty else {
            throw NameError.firstNameMissing
    }
    guard let lastName,
        !lastName.isEmpty else {
            throw NameError.lastNameMissing
    }
    return firstName + " " + lastName
}

do {
    let fooBar = try fullName(firstName: "foo", lastName: "bar", calculator: +)
    print("fooBar = \(fooBar)")
} catch NameError.firstNameMissing {
    print("firstNameMissing")
} catch NameError.lastNameMissing {
    print("lastNameMissing")
} catch {
    print("Got an error = \(error)")
}


// get previous positive integer
// fail more gracefully
// doesn't throw but carry error
// using Result<>

enum IntegerError: Error {
    case noPositiveIntegerBeforeZero(thisValue: Int)
}

func getPreviousPositiveInteger(
    from integer: Int
) -> Result<Int, IntegerError> {
    guard integer > 0 else {
        return Result.failure(IntegerError.noPositiveIntegerBeforeZero(thisValue: integer))
    }
    return Result.success(integer - 1)
}

func performGet(forValue value: Int) {
    switch getPreviousPositiveInteger(from: value) {
    case .success(let previousPositiveInteger):
        print("previousPositiveInteger = \(previousPositiveInteger)")
    case .failure(let error):
        switch error {
        case .noPositiveIntegerBeforeZero(let thisValue):
            print("noPositiveIntegerBeforeZero for \(thisValue)")
        }
}

performGet(forValue: 0) // noPositiveIntegerBeforeZero for 0
performGet(forValue: 1) // previousPositiveInteger = 0