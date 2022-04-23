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

## Comnine Features

### Generic
### Type safe
### Composition first
### Request-driven
