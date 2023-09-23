import Foundation

// enum is a value type

// struct Animal {
//     let type: String
//     init type == "Dog" || type == "Cat" || type == "Bird" {
//         self.type = type
//     } else {
//         preconditionFailure("Unknown animal type")
//     }
// }
// Animal(type: "Dog") // Dog

enum Animals {
    case Dog
    case Cat
    case Bird
}

let dog = Animals.Dog

if dog == Animals.Dog {
    print("Dog")
}

// switch
// need to be exhaustive
switch dog {
case .Dog:
    print("Dog")
    break
case .Cat:
    print("Cat")
    break
default: // normally not a good idea to use default
    print("Bird")
    break
}


// advance
// enum with associated value
// dynamically added at the time of creation
enum Shortcut {
    case fileOrFolder(path: URL, name: String)
    case url(path: URL)
    case song(artist: String, title: String)
}

let apple = Shortcut.url(path: URL(string: "https://apple.com")!)

// how to compare
// if apple == Shortcut.url(path: URL(string: "https://apple.com")!) {
//     print("same")
// } error, need to implement equatable

switch apple {
case let .url(path):
    print(path)
    break
case let .fileOrFolder(path, name):
    print(path, name)
    break
case let  .song(artist, title):
    print(artist, title)
    break
}

if case let .url(path) = apple {
    print(path)
} 

// ignore value
let withoutYou = Shortcut.song(artist: "Mariah Carey", title: "Without You")
if case .song(_, title) = withoutYou {
    print("Song title: \(title)")
} // Song title: Without You 


 
 // function
func isSong(_ shortcut: Shortcut) -> Bool {
    if case .song = shortcut {
        return true
    }
    return false
}

enum Vehicle {
    case Car(manufacturer: String, model: String)
    case Bike(manufacturer: String, model: String)

    // computed property
    var manufacturer: String {
        switch self {
        case let .Car(manufacturer, _),
            let .Bike(manufacturer, _):
            return manufacturer
        }
    }
//     func getManufacturer() -> String {
//         switch self {
//         case let .Car(manufacturer, _):
//             return manufacturer
//         case let .Bike(manufacturer, _):
//             return manufacturer
//         }
//     }
}

// func getManufacturer(_ vehicle: Vehicle) -> String {
//     switch vehicle {
//     case let .Car(manufacturer, _):
//         return manufacturer
//     case let .Bike(manufacturer, _):
//         return manufacturer
//     }
// }

let car = Vehicle.Car(manufacturer: "Tesla", model: "Model S")
// car.getManufacturer() // Tesla
car.manufacturer // Tesla


// enum with raw values
enum FamilyMember: String{
    case Father = "Dad"
    case Mother = "Mom"
    case Son = "Son"
    case Daughter = "Daughter"
}
FamilyMember.Father.rawValue // Dad


// CaseIterable
enum FavoriteEmoji: String, CaseIterable {
    case Love = "❤️"
    case Laugh = "😂"
    case Wow = "😮"
    case Sad = "😢"
    case Angry = "😡"
}

FavoriteEmoji.allCases // [Love, Laugh, Wow, Sad, Angry]
FavoriteEmoji.allCases.map(\.rawValue) // ["❤️", "😂", "😮", "😢", "😡"]

FavoriteEmoji(rawValue: "😡") // Angry
FavoriteEmoji.Angry.rawValue // 😡


enum Height {
    case short, medium, tall
    mutating func increaseHeight() {
        switch self {
        case .short:
            self = .medium
            break
        case .medium:
            self = .tall
            break
        case .tall:
            break
        }
    }
}

var height = Height.short
height.increaseHeight() // medium

// indirect enumarations
// indirec means the enum can be recursive
// advance swift
indirect enum IntOperation {
    case add(Int, Int)
    case subtract(Int, Int)
    case freehand(IntOperation)

    func calculate(
        of operation: IntOperation? = nil
    ) -> Int {
        switch operation ?? self {
        case let .add(left, right):
            return left + right
        case let .subtract(left, right):
            return left - right
        case let .freehand(operation):
            return calculate(of: operation)
        }
    }
}

let freeHand = IntOperation.freehand(.add(1, 2))
freeHand.calculate() // 3