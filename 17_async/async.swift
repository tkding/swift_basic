import Foundation
import PlaygroundSupport
import _Concurrency 

PlaygroundPage.current.needsIndefiniteExecution = true

// in window
// create a project that run indefinitely
// create a loop that nvr ends

// asynchoronous programming
// async function doesn't immediately return a result
// some doesn't return a result at all

// async await
// async let

// delay return of a result
func calculateFullName(
    firstName: String,
    lastName: String,
) async -> String {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return firstName + " " + lastName
}

Task {
    let fullName = await calculateFullName(firstName: "John", lastName: "Doe")
    print(fullName)
    async let fullName2 = calculateFullName(firstName: "John", lastName: "Doe")
    print(await fullName2)
}


enum Clothe {
    case shirt
    case pants
    case shoes
    case socks
}

func buySocks() async throws -> Clothe {
    try await Task.sleep(nanoseconds: 1_000_000_000)
    return .socks
}

func buyShoes() async throws -> Clothe {
    try await Task.sleep(nanoseconds: 1_000_000_000)
    return .shoes
}

func buyPants() async throws -> Clothe {
    try await Task.sleep(nanoseconds: 1_000_000_000)
    return .pants
}

// ensemble
struct Ensemble: CustomDebugStringConvertible {
    let clothes: [Clothe]
    let totalCost: Int

    var debugDescription: String {
        return "Ensemble: \(clothes) for a total of $\(totalCost)"
    }
}

func buyWholeEnsemble() async throws -> Ensemble {
    async let socks = buySocks()
    async let shoes = buyShoes()
    async let pants = buyPants()

    let ensemble = Ensemble(
        clothes: [try await socks, try await shoes, try await pants],
        totalCost: 200
    )

    return ensemble
}

Task {
    if let ensemble = try? await buyWholeEnsemble() {
        print(ensemble)
    } else {
        print("Couldn't buy the whole ensemble")}
}

// async let can only be used in async closure or async function
// or whenever there is a task being run

func getFullName(
    delay: Duration,
    calculator: () async -> String
)   async -> String{
    try? await Task.sleep(for: delay)
    return await calculator()
}

func fullName() async -> String {"Foo Bar"}

Task {
    await getFullName( 
        delay: .seconds(1)
    ) {
        async let name = fullName()
        return await name
    }
}

