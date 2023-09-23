import Foundation

struct Person: Equatable {
    let id: String
    let name: String
}

let foo1 = Person(id: "123", name: "Foo")
let foo2 = Person(id: "123", name: "Foo")

if foo1 == foo2 {
    print("foo1 and foo2 are equal")
} else {
    print("foo1 and foo2 are not equal")
}

extension Person: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (
        lhs: Person,
        rhs: Person
    ) -> Bool {
        return lhs.id == rhs.id
    }
}


enum AnimalType: Equatable {
    case dog(breed: String)
    case cat(breed: String)
}

let dog1 = AnimalType.dog(breed: "Poodle")
let dog2 = AnimalType.dog(breed: "Poodle")

if dog1 == dog2 {
    print("dog1 and dog2 are equal")
} else {
    print("dog1 and dog2 are not equal")
}
// result: dog1 and dog2 are equal

// the same as default implementation
// extension AnimalType: Equatable {
//     static func == (
//         lhs: AnimalType,
//         rhs: AnimalType
//     ) -> Bool {
//         switch (lhs, rhs) {
//         case let (.dog(lhsBreed), .dog(rhsBreed)),
//             let (.cat(lhsBreed), .cat(rhsBreed)):
//             return lhsBreed == rhsBreed
//         default:
//             return false
//         }
//     }
// }

struct Animal: Equatable {
    let name: String
    let type: AnimalType

    static func == (
        lhs: Animal,
        rhs: Animal
    ) -> Bool {
        return lhs.type == rhs.type
    }
}

let cat1 = Animal(name: "Cat1", type: .cat(breed: "Persian"))
let cat2 = Animal(name: "Cat2", type: .cat(breed: "Persian"))

if cat1 == cat2 {
    print("cat1 and cat2 are equal")
} else {
    print("cat1 and cat2 are not equal")
} // result: cat1 and cat2 are equal






// hashable
struct House: Hashable {
    let number: Int
    let numberOfBedrooms: Int
}

let house1 = House(number: 1, numberOfBedrooms: 2)
let house2 = House(number: 1, numberOfBedrooms: 2)

// the hash value will be the same
house1.hashValue 
house2.hashValue 

let house3 = House(number: 2, numberOfBedrooms: 2)
let houses = Set([house1, house2, house3])
houses.count // 2

struct NumberedHouse: Hashable {
    let number: Int
    let numberOfBedrooms: Int

    // if the have the same number, they are the same house
    func hash(into hasher: inout Hasher) {
        hasher.combine(number)
    }

    static func == (
        lhs: NumberedHouse,
        rhs: NumberedHouse
    ) -> Bool {
        return lhs.number == rhs.number
    }
}
let numberedHouse1 = NumberedHouse(number: 1, numberOfBedrooms: 2)
let numberedHouse2 = NumberedHouse(number: 1, numberOfBedrooms: 3)
let numberedHouse3 = NumberedHouse(number: 2, numberOfBedrooms: 2)
let numberedHouses = Set([numberedHouse1, numberedHouse2, numberedHouse3])
numberedHouses.count // 2


// enum are hashable by default
enum CarPart {
    case engine
    case tires
    case body
}

let uniqueParts: Set<CarPart> = [.engine, .tires, .bodyl .engine]
uniqueParts.count // 3

enum HouseType {
    case bungalow(NumberedHouse)
    case cottage(NumberedHouse)
}

let houseType1 = HouseType.bungalow(NumberedHouse(number: 1, numberOfBedrooms: 2))
let houseType2 = HouseType.bungalow(NumberedHouse(number: 1, numberOfBedrooms: 3))
let houseType3 = HouseType.cottage(NumberedHouse(number: 1, numberOfBedrooms: 2))
let houseTypes = Set([houseType1, houseType2, houseType3])
houseTypes.count // 2