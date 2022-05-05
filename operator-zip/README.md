# <a href="https://developer.apple.com/documentation/combine/publisher/zip(_:_:)-8d7k7">Zip( _ : _ : _ : )</a>
- **Zip**을 사옹해 최대 세 개의 Publisher를 결합할 수 있다.
- **Zip**은 결합된 Publishser들의 요소로 이루어진 tuple을 downstream에 publish하는 **새로운 Publishser를 반환한다.**
- 새로운 Publishser는 결합된 Publisher들이 모두 이벤트를 내보낼 때까지 기다렸다가, 
- 각 Publisher의 소비되지 않은 가장 오래된 value들로 만들어진 tuple을 downstream에 publish한다.

<br>

```swift
let numbersPub = PassthroughSubject<Int, Never>()
let lettersPub = PassthroughSubject<String, Never>()
let emojiPub = PassthroughSubject<String, Never>()

_ = numbersPub
    .zip(lettersPub, emojiPub) // -> 이 부분에 최대 3개, 결국은 총 4개의 Publisher가 결합되는 느낌?
    .sink { print("\($0)") }

numbersPub.send(1)     // numbersPub: 1      lettersPub:          emojiPub:        zip output: <none>
numbersPub.send(2)     // numbersPub: 1,2    lettersPub:          emojiPub:        zip output: <none>
numbersPub.send(3)     // numbersPub: 1,2,3  lettersPub:          emojiPub:        zip output: <none>
lettersPub.send("A")   // numbersPub: 1,2,3  lettersPub: "A"      emojiPub:        zip output: <none>
emojiPub.send("😀")    // numbersPub: 2,3    lettersPub: "A"      emojiPub: "😀"   zip output: (1, "A", "😀")
lettersPub.send("B")   // numbersPub: 2,3    lettersPub: "B"      emojiPub:        zip output: <none>
emojiPub.send("🥰")    // numbersPub: 3      lettersPub:          emojiPub:        zip output: (2, "B", "🥰")

// Prints:
//  (1, "A", "😀")
//  (2, "B", "🥰")
```
