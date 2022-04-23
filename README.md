# Let's learn Combine :)

### Introducing Combine
Cocoa SDK에는 Target/Action, NotificationCenter, ad-hoc callback과 같은 많은 비동기 인터페이스가 있다.<br>
비동기 API는 closure나 completion block을 가지고 각각의 상황에 맞게 사용되지만 이것들을 함께 사용할 경우 nested closures, convention-based callbacks 와 같은 어려움을 발생시키기도 한다. 

이러한 문제를 해결하기 위해 Apple은 비동기 API를 대체할 무언가가 아닌 비동기 API가 가진 공통점을 Combine을 통해 찾기 시작했다.

<br>

### Combine

Combine is a unified declarative API for processing values over time.
Combine is written in and for Swift.
That means we can take advantage of Swift features like Generics.

Generics let us reduce the amount of boilerplate code that you need to write.
It also means that we can write generic algorithms about asynchronous behaviors once and have them apply to all kinds of different asynchronous interfaces.

Combine is also type safe, allowing us to catch errors at compile time instead of at runtime.

Our main design point about Combine is that it is composition first.
What that means is that the core concepts are simple and easy to understand, but when you put them together, you can make something that's more than the sum of its parts.

And finally, Combine is request-driven, allowing you the opportunity to more carefully manage the memory usage and performance of your app.

So let's talk about those key concepts.
There's only three: Publishers, Subscribers and Operators.
