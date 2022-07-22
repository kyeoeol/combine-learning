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


// 3. switchToLatest

print("-------------switchToLatest--------------")

let publisher31 = PassthroughSubject<String, Never>()
let publisher32 = PassthroughSubject<String, Never>()

let publishers = PassthroughSubject<PassthroughSubject<String, Never>, Never>()

publishers
    .switchToLatest()
    .sink {
        print($0)
    }

publishers.send(publisher31)

publisher31.send("publisher31 - value1")
publisher31.send("publisher31 - value2")

publishers.send(publisher32) // swithing to publisher32

publisher32.send("publisher32 - value1")

publisher31.send("publisher31 - value3")

print("-------------switchToLatest continue--------------")

//let images = ["houston", "denver", "seattle"]
//var index = 0
//
//func getString() -> AnyPublisher<String?, Never> {
//    return Future<String?, Never> { promise in
//        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
//            promise(.success(images[index]))
//        }
//    }
//    .print()
//    .receive(on: RunLoop.main)
//    .eraseToAnyPublisher()
//}
//
//let taps = PassthroughSubject<Void, Never>()
//
//let subscription = taps
//    .print()
//    .map { _ in
//        getString()
//    }
//    .switchToLatest()
//    .sink {
//        print($0)
//    }
//
//// houston
//taps.send()
//
//// denver
//DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
//    index += 1
//    taps.send()
//}
//
//// seattle
//DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
//    index += 1
//    taps.send()
//}


// 4. merge

print("-------------merge--------------")

let publisher41 = PassthroughSubject<Int, Never>()
let publisher42 = PassthroughSubject<Int, Never>()


publisher41
    .merge(with: publisher42)
    .sink {
        print($0)
    }

publisher41.send(10)
publisher41.send(11)

publisher42.send(12)
publisher42.send(13)


// 5. combineLatest

print("-------------combineLatest--------------")

let publisher51 = PassthroughSubject<Int, Never>()
let publisher52 = PassthroughSubject<String, Never>()

publisher51
    .combineLatest(publisher52)
    .sink {
        print("P1: \($0), P:2 \($1)")
    }

publisher51.send(1)
publisher52.send("A")
publisher51.send(2)

publisher52.send("B")
publisher51.send(3)


// 6. zip

print("-------------zip--------------")

let publisher61 = PassthroughSubject<Int, Never>()
let publisher62 = PassthroughSubject<String, Never>()

publisher61
    .zip(publisher62)
    .sink {
        print("P1: \($0), P:2 \($1)")
    }

publisher61.send(1)
publisher62.send("A")
publisher61.send(2)
publisher61.send(3)
publisher61.send(4)

publisher62.send("B")
publisher61.send(5)
