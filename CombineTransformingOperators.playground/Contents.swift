import UIKit
import Combine

// MARK: - Transforming Operators

// 1. Collect

["A", "B", "C", "D", "E"].publisher
    .collect(2)
    .sink {
        print($0)
    }


// 2. map

let formatter: NumberFormatter = .init()
formatter.numberStyle = .spellOut

[123, 45, 67].publisher
    .map {
        formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
    }
    .sink {
        print($0)
    }


// 3. map KeyPath

struct MyPoint {
    let x: Int
    let y: Int
}

let publisher: PassthroughSubject<MyPoint, Never> = .init()

publisher
    .map(\.x, \.y)
    .sink { x, y in
        print("x is \(x) and y is \(y)")
    }

publisher.send(MyPoint(x: 12, y: 10))


// 4. flatMap

struct School {
    let name: String
    let numOfStudents: CurrentValueSubject<Int, Never>
    
    init(name: String, numOfStudents: Int) {
        self.name = name
        self.numOfStudents = .init(numOfStudents)
    }
}

let citySchool: School = .init(name: "Fountain Head School", numOfStudents: 100)

let school: CurrentValueSubject<School, Never> = .init(citySchool)

school
    .flatMap {
        $0.numOfStudents
    }
    .sink {
        print($0)
    }

let townSchool: School = .init(name: "Town Head School", numOfStudents: 45)

school.value = townSchool

citySchool.numOfStudents.value += 1
townSchool.numOfStudents.value += 10


// 5. replaceNil

["A", "B", nil ,"C"].publisher
    .replaceNil(with: "*")
    .map { $0! }
    .sink {
        print($0)
    }


// 6. replaceEmpty

let empty: Empty<Int, Never> = .init()

empty
    .replaceEmpty(with: 1)
    .sink(receiveCompletion: {
        print($0)
    }, receiveValue: {
        print($0)
    })


// 7. scan

let publisher2 = (1...10).publisher

publisher2
    .scan([]) { numbers, value -> [Int] in
        numbers + [value]
    }
    .sink {
        print($0)
    }
