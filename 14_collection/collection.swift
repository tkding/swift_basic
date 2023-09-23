import Foundation

let numbers: [Int] = [1, 2, 3, 4]
print(numbers.first!)
print(numbers.last!)
print(numbers.count)
print(numbers.map(-))

var mutatingNumbers = [4, 5, 6]
mutatingNumbers.append(7)
mutatingNumbers.append(contentsOf: [8, 9])
mutatingNumbers.insert(3, at: 2)
mutatingNumbers.remove(at: 0)

// enumerating
for number in mutatingNumbers {
    print(number)
}

// with condition
for value in numbers where value % 2 == 0 {
    print(value)
}

numbers.map { (value: Int) -> Int in
    return value * 2
} // [2, 4, 6, 8]

// easier
// numbers.map { value in
//     return value * 2
// }

numbers.filter { (value: Int) -> Bool in
    return value % 2 == 0
} // [2, 4]

// compact mapping
// map and filter
numbers.compactMap { (value: Int) -> Int? in
    return value % 2 == 0 ? value*2 : nil
} // [4, 8]


let numbers2: [Int?] = [1, 2, nil, 3, 4]
numbers2.count // 5
numbers2.compactMap { $0 } // [1, 2, 3, 4]
// or
let notNils = numbers2.filter { (value: Int?) -> Bool in 
    return value != nil }
// the arrays is till optional
// filter doesn't change data type
// compactMap changes data type
let notNils2 = numbers2.compactMap { (value: Int?) -> Int? in 
    return value }
// [1, 2, 3, 4] // type = [Int]

// not unique
let numbers3 = [1, 2, 1, 2]

// heterogenous
// mix of different types
let stuff1 = [
    1, 
    "two",
    3.0,
] as [Any]
stuff1[0] // 1
stuff1[1] // "two"
stuff1.count // 3

// or 
let stuff2: [Any] = [
    1, 
    "two",
    3.0,
]



// set 
// only unique values
// based on hash values and equality
// can't guranatee order
let uniqueNumbers = Set([1, 2, 3, 4, 5, 5, 5, 5])
uniqueNumbers.count // 5
print(uniqueNumbers) // [2, 3, 4, 5, 1]
uniqueNumbers.contains(1) // true
uniqueNumbers.contains(6) // false

let myNumbers = Set([1, 2, 3, nil, 5])
let notNilNumbers = Set(myNumbers.compactMap { $0 }) // [1, 2, 3, 5]

// heterogenous
let stuff3: Set<AnyHashable> = [
    1, 
    "two",
    3.0,
]
stuff3.count // 3 

// getting elements of same type from heterogenous array
// get only integers
let intsInStuff1 = stuff1.compactMap { (value: Any) -> Int? in 
    value as? Int 
} // [1]

// with set
let intsInStuff3 = stuff3.compactMap { (value: AnyHashable) -> Int? in 
    value as? Int 
} // [1] 
type(of: intsInStuff3) // Array<Int>
    // result of compactMap is an array

// how does set calculate uniqueness?
// hash value and equality
struct Person: Hashable{
    let id: UUID
    let name: String
    let age: Int
}
let fooId = UUID()
let foo = Person(id: fooId, name: "Foo", age: 20)
let bar = Person(id: fooId, name: "Bar", age: 30)
let people: Set<Person> = [foo, bar]
people.count // 2

// creating own has
struct Person2: Hashable{
    let id: UUID
    let name: String
    let age: Int

    // need to change hasing
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    // and equality
    static func == (lhs: Person2, rhs: Person2) -> Bool {
        return lhs.id == rhs.id
    }
}

let bazId = UUID()
let baz = Person2(
    id: bazId,
    name: "Baz",
    age: 20
)
let qux = Person2(
    id: bazId, 
    name: "Qux",
    age: 30
)
if baz == qux {
    print("They are equal")
}

let people2 = Set([baz, qux])
people2.count // 1
people2.first!.name


// dictionary
// json object

let userInfo = [
    "name": "Foo",
    "age": 20,
    "address": [
        "street": "123 Bar St",
        "city": "Baz",
        "state": "CA",
        "zip": "12345"
    ]
] as [String: Any]

userInfo["name"] // "Foo"
userInfo["age"] // 20
userInfo["address"] // ["street": "123 Bar St", "city": "Baz", "state": "CA", "zip": "12345"]
// dont do this in real life, dangerous
// userInfo["address"]!["street"] // "123 Bar St"
// safer
if let address = userInfo["address"] as? [String: Any] {
    address["street"] // "123 Bar St"
}

userInfo.keys // ["name", "age", "address"]
userInfo.values // ["Foo", 20, ["street": "123 Bar St", "city": "Baz", "state": "CA", "zip": "12345"]]

for (key, value) in userInfo {
    print("\(key): \(value)")
}

for (key, value) in userInfo where key == "name" {
    print("\(key): \(value)")
}

for (key, value) in userInfo where value is Int && key.count > 2{
    print("\(key): \(value)")
}
// result: age: 20


