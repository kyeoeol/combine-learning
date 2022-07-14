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
