# Let's learn Combine :)

## Introducing Combine
Cocoa SDK에는 Target/Action, NotificationCenter, ad-hoc callback과 같은 많은 비동기 인터페이스가 있다.<br>
비동기 API는 closure나 completion block을 가지고 각각의 상황에 맞게 사용되지만 이것들을 함께 사용할 경우 nested closures, convention-based callbacks 와 같은 어려움을 발생시키기도 한다. 

이러한 문제를 해결하기 위해 Apple은 비동기 API를 대체할 무언가가 아닌 비동기 API가 가진 공통점을 Combine을 통해 찾기 시작했다.

<br>

## Combine
Combine은 **시간에 따른 값(values) 처리를 위한 통합 선언 API(a unified declarative API)** 이다. <br>
Combine으로 처리되는 값들은 많은 종류의 비동기 이벤트를 대체할 수 있고 Combine의 이벤트 처리 연산자를 이용해 비동기 이벤트를 다룰 수 있다. <br>
간단하게 말하자면 Combine은 비동기 이벤트를 처리하기 위한 API라고 할 수 있다.

<br>

## Comnine Features
### Generic
Combine은 Swift용으로 작성되었는데 Generics과 같은 Swift의 기능을 활용할 수 있다는 걸 의미한다. <br>
Generics을 사용하면 작성해야 하는 코드의 양을 줄일 수 있고 한 번 작성된 비동기 동작에 대한 알고리즘을 다른 종류의 비동기 API에서 사용할 수 있다.

### Type safe
Combine은 Type safe하기 때문에 런타임이 아닌 컴파일 시간에 에러를 잡을 수 있다.

### Composition first
'Composition first'는 Combine의 주요 디자인 포인트이다. <br>
핵심 개념은 간단하고 이해하기 쉽지만 이 개념들을 함께 사용했을 때 Combine의 장점을 극대화 시킬 수 있다는 걸 의미한다.

### Request-driven
Combine은 요청 기반의 API이기 때문에 메모리 사용량과 앱의 성능을 신중하게 관리할 수 있다.

<br>

## Key Concepts
### Publisers
Publiser는 값과 에러가 생성되는 방식을 설명(describe)하는 Combine의 선언적인 부분(declarative part of Combine's API)이다. <br>
이는 실제 Publiser가 값과 에러를 생성하는 것이 아니라는 것을 의미한다.

**Fetures**
- Defines how values and errors are produced
- Value Type
- Allows registration of a subscriber

**Protocol**
```swift
protocol Publiser {
    associatedtype Output
    associatedtype Failure: Error

    func subscribe<S: Subscriber>(_ subscriber: S) {
        where S.Input == Output, S.Failure == Failure
    }
}
```
- Output: 생성되는 값에 대한 associatedtype
- Failure: 생성되는 에러에 대한 associatedtype, 에러를 생성할 수 없는 경우 Never 타입으로 처리한다.
- subscribe: Publiser의 핵심 기능, subscriber의 Input과 Publiser의 Output이 일치해야 하고 각각의 Failure도 일치해야 한다.

**Example**
```swift
extension NotificationCenter {
    struct Publisher: Combine.Publisher {
        typealias Output = Notification
        typealias Failure = Never
        
        init(center: NotificationCenter, name: Notification.Name, object: Any? = nil)
    }
}
```
- struct로 사용된 Publisher
- Notification 타입의 Output
- 에러를 생성하지 않는 Never 타입의 Failure
- NotificationCenter를 대체하는 것이 아니라 NotificationCenter에 Publisher를 적용시키는 것을 볼 수 있다.

### Subscribers

### Operators

