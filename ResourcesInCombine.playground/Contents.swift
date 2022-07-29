import UIKit
import Combine

var subscription3: AnyCancellable?

guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
    fatalError("Invalid URL")
}

let subject = PassthroughSubject<Data, URLError>()

let request = URLSession.shared.dataTaskPublisher(for: url)
    .map(\.data)
    .print()
//    .share()
    .multicast(subject: subject)

let subscription1 = request.sink(receiveCompletion: { _ in}, receiveValue: {
    print("""
    
    subscription1: \($0)
    
    """)
})

let subscription2 = request.sink(receiveCompletion: { _ in}, receiveValue: {
    print("""
    
    subscription2: \($0)
    
    """)
})

//DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    subscription3 = request.sink(receiveCompletion: { _ in}, receiveValue: {
        print("""
        
        subscription3: \($0)
        
        """)
    })
//}

request.connect()
subject.send(Data())
