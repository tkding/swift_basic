import Foundation

// let immutable : can't reassign
// var mutable

let myName = "Ding"
let yourName = "Foo"

// array
var names = [
    myName,
    yourName
]

names = ["Bla"] // assign a new value

names.append("Bar") // mutate name internally
names.append("Baz")

/// value type: copy on write 
/// * classes are reference type
 
let oldArray = NSMutableArray(array: [1, 2, 3])
let newArray = oldArray
newArray.add(4)
print(oldArray) // [1, 2, 3, 4]

func changeArray(_ array: NSArray) {
    let copy = array as! NSMutableArray // bad code
    // let copy = array.mutableCopy() as! NSMutableArray
    copy.add(5)
}

changeArray(oldArray) // [1, 2, 3, 4, 5]
print(oldArray) // [1, 2, 3, 4, 5]