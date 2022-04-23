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
