import UIKit
import Combine


// MARK: - Filtering Operators

// 1. filter

print("-------------filter--------------")

let numbers = (1...20).publisher

numbers
    .filter { $0 % 2 == 0 }
    .sink {
        print($0)
    }



// 2. removeDuplicates

print("-------------removeDuplicates--------------")

let words = "apple apple apple fruit fruit apple apple mango watermelon apple".components(separatedBy: " ").publisher

words
    .removeDuplicates()
    .sink {
        print($0)
    }


// 3. compactMap

print("-------------compactMap--------------")

let strings = ["a", "1.24", "b", "3.45", "6.7"].publisher

strings
    .compactMap { Float($0) }
    .sink {
        print($0)
    }


// 4. ignoreOutput

print("-------------ignoreOutput--------------")

let numbers2 = (1...5000).publisher

numbers2
    .ignoreOutput()
    .sink {
        print($0)
    } receiveValue: {
        print($0)
    }


// 5. first

print("-------------first--------------")

let numbers3 = (1...9).publisher

numbers3
    .first { $0 % 2 == 0 }
    .sink {
        print($0)
    }


// 6. last

print("-------------last--------------")

let numbers4 = (1...9).publisher

numbers4
    .last { $0 % 2 == 0 }
    .sink {
        print($0)
    }


// 7. dropFirst

print("-------------dropFirst--------------")

let numbers5 = (1...10).publisher

numbers5
    .dropFirst(3)
    .sink {
        print($0)
    }


// 8. dropWhile

print("-------------dropWhile--------------")

let numbers6 = (1...10).publisher

numbers6
    .drop(while: {
        $0 % 3 != 0
    })
    .sink {
        print($0)
    }


// 9. dropUntilOutputFrom

print("-------------.dropUntilOutputFrom--------------")

let isReady: PassthroughSubject<Void, Never> = .init()
let taps: PassthroughSubject<Int, Never> = .init()

taps
    .drop(untilOutputFrom: isReady)
    .sink {
        print($0)
    }

(1...10).forEach {
    taps.send($0)
    
    if $0 == 5 {
        isReady.send(())
    }
}


// 10. prefix

print("-------------prefix--------------")

let numbers7 = (1...10).publisher

numbers7
    .prefix(3)
    .sink {
        print($0)
    }

print("-------------prefix while--------------")

numbers7
    .prefix { $0 < 5 }
    .sink {
        print($0)
    }


// Challenge 1. Filter all the things
/*
 Challenge: Filter all the things

 Create an example that publishes a collection of numbers from 1 through 100, and use filtering operators to:

 1. Skip the first 50 values emitted by the upstream publisher.
 2. Take the next 20 values after those first 50 values.
 3. Only take even numbers.

 The output of your example should produce the following numbers, one per line:
 52 54 56 58 60 62 64 66 68 70
 */

print("-------------Filter all the things--------------")

let cNumbers = (1...100).publisher

cNumbers
    .dropFirst(50)
    .prefix(20)
    .filter { $0 % 2 == 0 }
    .sink {
        print($0)
    }
