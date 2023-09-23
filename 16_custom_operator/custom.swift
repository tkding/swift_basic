import Foundation

let firstName: String = "John"
let lastName: String = "Doe"
let fullName: String = firstName + " " + lastName

print(fullName) // John Doe

// optional 
let optionalFirstName: String? = "John"
let optionalLastName: String? = "Doe"

// func + (lhs: String?, rhs: String?) -> String? {
//     guard let lhs = lhs, let rhs = rhs else {
//         return nil
//     }
//     return lhs + " " + rhs
// }

// binary infix operator + 
func + (lhs: String?, rhs: String?) -> String? {
   switch (lhs, rhs) {
    case let (.some(lhs), .some( rhs)):
         return lhs + " " + rhs
    case let (.some(lhs), .none):
         return lhs
    case let (.none, .some(rhs)):
        return rhs
    case (.none, .none):
        return nil
    }
}

let optionalFullName: String? = optionalFirstName + optionalLastName
print (optionalFullName) // Optional("John Doe")

// unary prefix operator ^
prefix operator ^ // declare operator
prefix func ^ (value: String) -> String {
    return value.uppercased()
}

let lowercaseName = "john"
let uppercaseName = ^lowercaseName
print(uppercaseName) // JOHN

// unary postfix operator *
postfix operator *
postfix func * (value: String) -> String {
    return value + " 🌟"
}

let withStars = lowercaseName*
print(withStars) // john 🌟



struct Person{
    let name: String
}

struct Family {
    let members: [Person]
}

let john = Person(name: "John")
let jane = Person(name: "Jane")
let son = Person(name: "Son")
let daughter1 = Person(name: "Daughter1")
let daughter2 = Person(name: "Daughter2")

// binary infix operator +
func + (lhs: Person, rhs: Person) -> Family {
    let family = Family(members: [lhs, rhs])
    return family
}
func + (lhs: Family, rhs: Person) -> Family {
    var members = lhs.members
    members.append(rhs)
    return Family(members: members)
}
func + (lhs: Family, rhs: [Person]) -> Family {
    var members = lhs.members
    members.append(contentsOf: rhs)
    return Family(members: members)
}

let family = john + jane;
print(family.members) // [__lldb_expr_1.Person(name: "John"), __lldb_expr_1.Person(name: "Jane")]

let biggerFamily = family + son
print(biggerFamily.members) // [__lldb_expr_1.Person(name: "John"), __lldb_expr_1.Person(name: "Jane"), __lldb_expr_1.Person(name: "Son")]

let biggestFamily = biggerFamily + [daughter1, daughter2]
print(biggestFamily.members) // [__lldb_expr_1.Person(name: "John"), __lldb_expr_1.Person(name: "Jane"), __lldb_expr_1.Person(name: "Son"), __lldb_expr_1.Person(name: "Daughter1"), __lldb_expr_1.Person(name: "Daughter2")]

