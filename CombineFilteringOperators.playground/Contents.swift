import UIKit
import Combine

// MARK: - Filtering Operators

// 1. filter

let numbers = (1...20).publisher

numbers
    .filter { $0 % 2 == 0 }
    .sink {
        print($0)
    }


// 2. removeDuplicates

let words = "apple apple apple fruit fruit apple apple mango watermelon apple".components(separatedBy: " ").publisher

words
    .removeDuplicates()
    .sink {
        print($0)
    }


// 3. compactMap

let strings = ["a", "1.24", "b", "3.45", "6.7"].publisher

strings
    .compactMap { Float($0) }
    .sink {
        print($0)
    }


// 4. ignoreOutput

let numbers2 = (1...5000).publisher

numbers2
    .ignoreOutput()
    .sink {
        print($0)
    } receiveValue: {
        print($0)
    }

