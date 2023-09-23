import Foundation

// optional is a type that can hold either a value or nil
// optional is a generic enum

// num is an optional Int
func multiplyByTwo(_ num: Int? = nil) -> Int {
    if let num = num {
        return num * 2
    }
    return 0
}
multiplyByTwo(2) // 4
multiplyByTwo() // 0

let age: Int? = nil
if let age = age {
    print(age)
} else {
    print("age is nil")
}

// if let is a way to unwrap optional
// after unwrapping, the value is no longer optional


// guard
func checkAge() {
    // age is very important in this function
    // age is still optional
    guard age != nil else {
        print("age is nil")
        return
    }
    print("age is \(age)")
}

// guard is a way to unwrap optional
// after unwrapping, the value is no longer optional
let age2: Int? = 10
func checkAge2() {
    guard let age2 else { // unwrap age2
        print("age is nil")
        return
    }
    print("age is \(age2)")
}
chechAge2() // age is 10


switch age {
case let .some(value):
    print(value)
    break;
case .none:
    print("age is nil")
}

// using comparaotr
if age2 == .some(0) { // clear that age2 is optional
    print("age is 0")
} else {
    print("age is nil")
}


// optional chaining
// if any of the optional is nil, the whole chain will return nil
// if all of the optionals are not nil, the whole chain will return the last value
struct Person {
    var name: String
    let address: Address?
    struct Address {
        let street: String?
    }
}

let foo: Person = Person(name: "foo", address: nil)

if let fooFirstStreet = foo.address?.street?.first {
    print(fooFirstStreet)
} else {
    print("fooFirstStreet is nil")
}


// or 
if let fooFirstStreet = foo.address,
    let fooFirstStreet = fooFirstStreet.street,
    let fooFirstStreet = fooFirstStreet.first {
    print(fooFirstStreet)
} else {
    print("fooFirstStreet is nil")
}

let bar: Person? = Person(name: "bar", address: Person.address(
    street: "bar street"
))

// optional continue until it hits nil or the last value
if bar?name == "bar", 
    bar?.address?.street == "bar street" {
    print("bar is bar")
} else {
    print("bar is not bar")
}

// can use where clause to filter


func getFullName(_ firstName: String?, _ lastName: String?) -> String? {
    // make sure both firstName and lastName are not nil
    guard let firstName = firstName, let lastName = lastName else {
        return nil
    }
    return firstName + " " + lastName 
}


