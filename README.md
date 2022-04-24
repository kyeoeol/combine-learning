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
- **Output:** 생성되는 값에 대한 associatedtype
- **Failure:** 생성되는 에러에 대한 associatedtype, 에러를 생성할 수 없는 경우 Never 타입으로 처리한다.
- **subscribe:** Publiser의 핵심 기능, subscriber의 Input과 Publiser의 Output이 일치해야 하고 각각의 Failure도 일치해야 한다.

<br>

### Subscribers
Publiser의 counterpart인 Subscriber는 Publiser가 finite한 경우 completion 또는 values를 받는다. 
Subscriber는 일반적으로 값을 받으면 행동하고 상태를 변경하기 때문에 참조 타입을 사용한다.

**Fetures**
- Receives values and a completion
- Reference Type

**Protocol**
```swift
protocol Subscriber {
    associatedtype Iutput
    associatedtype Failure: Error
    
    func receive(subscription: Subscription)
    func receive(_ input: Input) -> Subscribers.Demand
    func receive(completion: Subscribers.Completion<Failure>)
}
```
- **Intput:** 생성되는 값에 대한 associatedtype
- **Failure:** 생성되는 에러에 대한 associatedtype, 에러를 생성할 수 없는 경우 Never 타입으로 처리한다.
- **receive(subscription: Subscription):** Publiser로 부터 받는 Subscription로 데이터 flow를 제어할 수 있다.
- **receive(_ input: Input):** Input 타입을 받는다.
- **receive(completion: Subscribers.Completion<Failure>):** 연결된 Publiser가 finite한 경우 완료(Finished) 또는 실패(Failure)에 대한 completion을 받는다.

<br>

### The Pattern - How to use Publishers and Subscribers together
1. Subscriber가 Publisher와 연결된다.
<img width="300" src="https://user-images.githubusercontent.com/80438047/164911644-49db17b0-bfbb-4682-8a38-697f8515c64d.png">

2. Publisher는 Subscriber에게 Subscription를 보낸다.
<img width="300" src="https://user-images.githubusercontent.com/80438047/164912059-5ba58745-235b-4dc9-b090-d0b239f2a6f3.png">

3. Subscriber는 Publisher로 부터 받은 Subscription로 Publisher에게 값 요청을 보낸다.
<img width="300" src="https://user-images.githubusercontent.com/80438047/164912183-3cf4b99c-4f7d-4493-ab98-50229a746cc3.png">

4. Publisher는 Subscriber에게 값을 보낸다.
<img width="300" src="https://user-images.githubusercontent.com/80438047/164912391-237d70ce-db17-4012-bea8-1ee7c25ebca6.png">

5. Publiser가 finite된 경우 Completion 또는 Error를 보낸다.
<img width="300" src="https://user-images.githubusercontent.com/80438047/164912447-cd7d7112-65f4-4126-b828-f101d57fc21e.png">

**하나의 Subscription으로 0개 또는 그 이상의 값을 받고 하나의 Completion으로 완료된다.**

<br>

### Operators
Operators are Publishers until they adopt the Publisher protocol.

예를 들어, grade라는 Int 타입을 가진 객체를 Output의 타입으로 가지는 Publisher과 Input 타입이 Int인 Subscriber를 서로 연결하려고 하는 경우 타입이 일치하지 않는 다는 에러가 발생하는데 이때 Operator를 사용해 타입을 일치시킴으로써 에러를 해결할 수 있다.

다시 말하자면, Operator는 upstream인 Publisher로부터 받은 값을 변경해 downstream인 Subscriber에게 다시 보내는 역할을 한다.
이 과정을 통해 Publisher로부터 받은 값을 쉽게 커스터마이징 할 수 있다.

**Fetures**
- Adopts Publisher
- Describe a behavior for changing values
- Subscribe to a Publisher ("upstream")
- Subscribe to a Subscriber ("downstream")
- Value Type

**Combine에는 Declarative Operator API 라고 불리는 정말 많은 Operator가 있다.** <br>

**Declarative Operator API**
- Functional transformations
- List Operations
- Error Handling
- Thread or queue movement
- Scheduling and time

<img width="600" src="https://user-images.githubusercontent.com/80438047/164981674-2973db49-f842-4c31-b383-66fa1de92a53.png">

**Apple은 수많은 Operator를 탐색하는 데 도움이 되도록 Swift Collection API에서 이미 사용되고 있는 이름을 참고해 Operator의 이름을 지었다.**

**Example**
<img width="400" src="https://user-images.githubusercontent.com/80438047/164982420-3c743756-ecfd-48b1-9489-d553c61c5508.png">
