# Let's learn Combine :)

### Introducing Combine
Cocoa SDK에는 Target/Action, NotificationCenter, ad-hoc callback과 같은 많은 비동기 인터페이스가 있다.<br>
비동기 API는 closure나 completion block을 가지고 각각의 상황에 맞게 사용되지만 이것들을 함께 사용할 경우 nested closures, convention-based callbacks 와 같은 어려움을 발생시키기도 한다.

이러한 문제를 해결하기 위해 Apple은 비동기 API를 대체할 무언가가 아닌  비동기 API가 가진 공통점을 찾았고 Combine이 등장하게 된다.
