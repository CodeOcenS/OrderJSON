# OrderJSON

## 简介
OrderJSON 是手动解析 json 字符串， 使得字典 key 与 json key顺序一致。
OrderJSON 并不是一个可以有顺序的字典。

该项目基于[josn--swiftDo](https://github.com/swiftdo/json)基础上，修复空数组和空对象 添加扩展方法 `any()`而来，具体原理参考源项目
参考文章
- [Swift 码了个 JSON 解析器(一)](https://oldbird.run/swift/fp/t3-json1.html)
- [Swift 码了个 JSON 解析器(二)](https://oldbird.run/swift/fp/t3-json2.html)
- [Swift 码了个 JSON 解析器(三)](https://oldbird.run/swift/fp/t3-json3.html)


目前仅支持 Swift Package Manager 集成
