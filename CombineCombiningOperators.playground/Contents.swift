import UIKit
import Combine


// MARK: - Combining Operators

// 1. prepend

print("-------------prepend--------------")

let numbers1 = (1...5).publisher
let publisher1 = (500...501).publisher

numbers1
    .prepend(100, 101)
    .prepend(-1, -2)
    .prepend([45, 67])
    .prepend(publisher1)
    .sink {
        print($0)
    }


// 2. append

print("-------------append--------------")

let numbers2 = (1...10).publisher
let publisher2 = (500...501).publisher

numbers2
    .append(100, 101)
    .append(-1, -2)
    .append([45, 67])
    .append(publisher2)
    .sink {
        print($0)
    }
