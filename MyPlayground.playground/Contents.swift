//
// Error Handling
// by
// Mahesh Gahlot <gahlotmahesh8@gmail.com>
//

enum MachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

// throw the error
// throw MachineError.insufficientFunds(coinsNeeded: 6)



struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Cakes": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Cookies": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {                 //pass error in calling code
        guard let item = inventory[name] else {
            throw MachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw MachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw MachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Mahesh": "Cakes",
    "Vibhor": "Chips",
    "Duke": "Cookies",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws{
    let snackName  = favoriteSnacks[person] ?? "Chips"
    try vendingMachine.vend(itemNamed: snackName)
    // Expression after try are Expressions in which error may Occur if error Occurs all the code bwfore catch is skip
}


struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}


// Handling Error Using Do Catch
/*
 
 use a do-catch statement to handle errors by running a block of code. If an error is thrown by the code in
 the do clause, it is matched against the catch clauses to determine which one of them can handle the error.
 
 */
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 10
do{
    try buyFavoriteSnack(person: "Vibhor", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch MachineError.invalidSelection {
    print("Invalid Selection.")
} catch MachineError.outOfStock {
    print("Out of Stock.")
} catch MachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}


func someThrowFuncton(n: Int) throws -> Int {
    do{
    if n<1{
        throw MachineError.outOfStock
    }
        return n
}}

//Convert Error to Optional valuts
// if error is occur the optional value set to nil
let x = try? someThrowFuncton(n: 2) // run without throwing errorr so x = 2
let y = try? someThrowFuncton(n: 0) //Error is Throe so y = nil
//
//Alternate of above expression
//
//do {
//    y = try someThrowingFunction(n: 0)
//} catch {
//    y = nil
//}
//
//In Both Cases y = nil
//


// Disabling Error Propagation
/*
Sometimes you know a throwing function or method won’t, throw an error at runtime. On those
occasions, you can write try! before the expression to disable error propagation and wrap the call in a
runtime assertion that no error will be thrown. If an error actually is thrown, you’ll get a runtime
error.
*/

//let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
// the image is shipped with the application,so no error will be thrown at runtime


// Specifying Cleanup Actions
//use a defer statement to execute a set of statements just before code execution leaves the current block of
//code

//like finally{....} in java expect that defer can used even without a try statement

//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // Work with the file.
//        }
//        // close(file) is called here, at the end of the scope.
//    }
//}
//defer statement can be used even when no error handling code is involved.

