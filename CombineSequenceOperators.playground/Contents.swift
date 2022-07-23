import UIKit
import Combine

// MARK: - Sequence Operators

// 1. mix and max

print("-------------mix and max--------------")

let publisher1 = [1, -45, 3, 45, 100].publisher

publisher1
//    .min()
    .max()
    .sink {
        print($0)
    }


// 2. first and last

print("-------------first and last--------------")

let publisher2 = ["A", "B", "C", "D"].publisher

publisher2
//    .first()
//    .first(where: { "Cat".contains($0) })
//    .last()
    .last(where: { "LOAD".contains($0) })
    .sink {
        print($0)
    }


// 3. output

print("-------------output--------------")

let publisher3 = ["A", "B", "C", "D"].publisher

publisher3
//    .output(at: 2)
    .output(in: 1...3)
    .sink {
        print($0)
    }


// 4. count

print("-------------count--------------")

let publisher41 = ["A", "B", "C", "D", "E", "F"].publisher

let publisher42 = PassthroughSubject<Int, Never>()

publisher41
    .count()
    .sink {
        print($0)
    }

publisher42
    .count()
    .sink {
        print($0)
    }

publisher42.send(10)
publisher42.send(20)
publisher42.send(30)
publisher42.send(completion: .finished)


// 5. contains

print("-------------contains--------------")

let publisher5 = ["A", "B", "C", "D"].publisher

publisher5
    .contains("F")
    .sink {
        print($0)
    }


// 6. allSatisfy

print("-------------allSatisfy--------------")

let publisher6 = [1, 2, 3, 4, 5, 6, 7].publisher

publisher6
    .allSatisfy {
        $0 % 2 == 0
    }
    .sink {
        print($0)
    }


// 7. reduce

print("-------------reduce--------------")

let publisher7 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher

publisher7
//    .reduce(0, +)
    .reduce(0) { accumulator, value in
        print("accumulator: \(accumulator) and the value is \(value)")
        return accumulator + value
    }
    .sink {
        print($0)
    }
