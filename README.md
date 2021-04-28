# OrderJSON

## 简介
OrderJSON 是手动解析 json 字符串， 使得字典 key 与 json key顺序一致。
OrderJSON 并不是一个可以有顺序的字典。

**背景**
在使用系统自带的 json 字符串转字典方法`JSONSerialization`后，发现字典是无序的。但是有时候我又想知道 key 的顺序。
所以在 [json -- swiftDo](https://github.com/swiftdo/json)基础上，使得我们可以获取 json 的 key 顺序。

参考文章
- [Swift 码了个 JSON 解析器(一)](https://oldbird.run/swift/fp/t3-json1.html)
- [Swift 码了个 JSON 解析器(二)](https://oldbird.run/swift/fp/t3-json2.html)
- [Swift 码了个 JSON 解析器(三)](https://oldbird.run/swift/fp/t3-json3.html)


目前仅支持 Swift Package Manager 集成
