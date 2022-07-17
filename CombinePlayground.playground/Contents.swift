import UIKit
import Combine


// MARK: - Example 1. The Foundation framework and Combine

extension Notification.Name {
    static let newBlogPost = Notification.Name("new_blog_post")
}

struct BlogPost {
    let title: String
    let url: URL
}

let blogPostPublisher = NotificationCenter.Publisher(
    center: .default,
    name: .newBlogPost,
    object: nil
)
    .map { notification -> String? in
        return (notification.object as? BlogPost)?.title
    }

let lastPostLabel = UILabel()
blogPostPublisher.assign(to: \.text, on: lastPostLabel)
//let lastPostLabelSubscriber = Subscribers.Assign(
//    object: lastPostLabel,
//    keyPath: \.text
//)
//
//blogPostPublisher
//    .subscribe(lastPostLabelSubscriber)

let blogPost = BlogPost(
    title: "The Foundation framework and Combine",
    url: URL(string: "https://apple.com")!
)

NotificationCenter.default.post(name: .newBlogPost, object: blogPost)

print("Last post is:", lastPostLabel.text ?? "") // --> Last post is: The Foundation framework and Combine




// MARK: - @Published usage to bind values to changes

final class FormViewModel {
    @Published var isSubmitAllowed = false
}

final class FormViewController: UIViewController {
    
//    @Published var isSubmitAllowed: Bool = false
//    private var subscribers: [AnyCancellable] = []
    private var switchSubscriber: AnyCancellable?
    private var viewModel = FormViewModel()
    
    @IBOutlet private weak var acceptTermsSwitch: UISwitch!
    @IBOutlet private weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // save the cancellable subscription
//        $isSubmitAllowed
        switchSubscriber =  viewModel.$isSubmitAllowed
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: submitButton)
    }
    
    @IBAction func didSwitch(_ sender: UISwitch) {
        viewModel.isSubmitAllowed = sender.isOn
    }
}




// MARK: - Make Subscriber

class StringSubscriber: Subscriber {
    
    typealias Input = String
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.max(3))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("--->Input:", input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        
    }
    
}

//let publisherSub: PassthroughSubject<String, Never> = .init()
let publisherArr = ["A","B","C","D","E","F"].publisher

let subscriber: StringSubscriber = .init()

publisherArr
    .subscribe(subscriber)

//publisherSub.send("A")
//publisherSub.send("B")
//publisherSub.send("C")
//publisherSub.send("D")




// MARK: - Type Eraser
// eraseToAnyPublisher()

let publisher = PassthroughSubject<Int, Never>().eraseToAnyPublisher()
