import Foundation

// generic helps to write reusable code
// generic is a placeholder for any type

func perform(_ op : (Int, Int) -> Int, on a: Int, and b: Int) -> Int {
    return op(a, b)
}
peform (+, on: 1, and: 2) // 3
perform (-, on: 1, and: 2) // -1
perform (*, on: 1, and: 2) // 2
perform (/, on: 1, and: 2) // 0

// generic function
func perform2<T: Numeric>(_ op: (T, T) -> T, on a: T, and b: T) -> T {
    return op(a, b)
}
perform2 (+, on: 1, and: 2) // 3
perform2 (-, on: 1.5, and: 2.5) // -1.0


func perform3<T>(_ op: (T, T) -> T, on a: T, and b: T) -> T where T: Numeric {
    return op(a, b)
}
perform3 (+, on: 1, and: 2) // 3
perform3 (-, on: 1.5, and: 2.5) // -1.0

// classes and structs can conform to protocols
protocol canJump{
    func jump()
}

protocol canRun {
    func run()
}

struct Person2: canJump, canRun {
    func jump() {
        print("jump")
    }
    func run() {
        print("run")
    }
}

func jumpAndRun<T: canJump & canRun>(_ obj: T) {
    obj.jump()
    obj.run()
}

let person = Person2()
jumpAndRun(person) // jump run

// extension on generic type
extension [String] {
    func longestString() -> String? {
        self.sorted { $0.count > $1.count }.first
    }
}

["foo", "bar", "foobar"].longestString() // foobar



// advance
// associate type in protocol
// associated type is a generic type in protocol
protocol View {
    func addSubView(_ view: Self)
}

extension View {
    func addSubView(_ view: Self) {
        print("add subview")
    }
}

struct Button: View {
    func addSubView(_ view: Button) {
        print("add button")
    }
}

struct Table: View {
    func addSubView(_ view: Table) {
        print("add table")
    }
}

// can define anything in your system that is presentable as a view as a protocl
// turn a protocol to a generic protocol
protocol PresentableAsView {
    associatedtype ViewType: View // ViewType is a generic type

    func produceView() -> ViewType
    func configure(
        superView: View, 
        thisView: ViewType  // superView can be any View
            // thisView can be any ViewType
    )
    func present(view: ViewType, on superView: View)
}

extension PresentableAsView {
    func configure(
        superView: View, 
        thisView: ViewType
    ) {
        superView.addSubView(thisView)
    }

    func present(view: ViewType, on superView: View) {
        superView.addSubView(view)
    }
}

struct MyButton: PresentableAsView {
    func produceView() -> Button {
        return Button()
    }

    // can see that ViewType is set as Button in this case
    func configure(
        superView: View, 
        thisView: Button
    ) {
        superView.addSubView(thisView)
    }

    func present(view: Button, on superView: View) {
        superView.addSubView(view)
    }
}

extension PresentableAsView where ViewType == Button {
    func doSomethingWithButton () {
        print("do something with button")
    }
}

let button = MyButton()
button.doSomethingWithButton() // do something with button
 
struct MyTable: PresentableAsView {
    func produceView() -> Table {
        return Table()
    }
}
let myTable = MyTable()
// myTable.doSomethingWithButton() // error line 135



extension [Int]{
    func average() -> Double {
        return Double(self.reduce(0, +)) / Double(self.count)
    }
}     
[1, 2, 3, 4, 5].average() // 3.0