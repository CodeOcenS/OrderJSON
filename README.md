# OrderJSON

## 简介
OrderJSON 是手动解析 json 字符串， 使得字典 key 与 json key顺序一致。

**主要功能**

* 手动解析 json 字符串
* 返回有序字典`OrderedDictionary`

**背景**
在使用系统自带的 json 字符串转字典方法`JSONSerialization`后，发现字典是无序的。但是有时候我又想知道 key 的顺序。
所以在 [json -- swiftDo](https://github.com/swiftdo/json)基础上，使得我们可以获取 json 的 key 顺序。

> Tip: 苹果官方提供有序字典、有序集合[开源项目](https://github.com/apple/swift-collections)，当我们关注顺序的时候可以引入使用

## 使用

比如这里我们想要获取某个路径下的 key 顺序

目标 json 字符串
``` javascript
{
    "stringValue": "字符串",
    "intValue": 20,
    "doubleValue": 12.8,
    "boolValue": false,
    "objectValue": {
        "objectKey1": "value1",
        "objectKey2": 2,
        "objectKey3": {
            "key1": "value1",
            "key2"："value2"
        }
    },
    "arrayValue1": [1, 2, 3],
    "arrayValue2": [{
        "name": "小明",
        "age": 18
    }],
    "emptyArray": [],
    "emptyObject": {},
    "nullValue": null
}
```
### 转换为 OrderJSON 

```swift
let json =
    """
{"stringValue":"字符串","intValue":20,"doubleValue":12.8,"boolValue":false,"objectValue":{"objectKey1":"value1","objectKey2":2,"objectKey3":{"key":"value"}},"arrayValue1":[1,2,3],"arrayValue2":[{"name":"小明","age":18}],"emptyArray":[],"emptyObject":{},"nullValue":null}
"""
let jsonObject = try? JsonParser.parse(text: json)
```
### 获取根 key 顺序

转化路径为数组方法
```swift 
private func transformStringToArray(_ string: String) -> [String] {
    if string.isEmpty {
        return []
    }
    return string.components(separatedBy: ".")
}
```
 通过路径数组，就可以获取对应 key 下子 key 的顺序数组
```swift
let rootPath = ""
let rootKeys = jsonObject.subKeysFor(keyPath: transformStringToArray(rootPath))
```
输出结果
```swift
(lldb) po rootKeys
▿ 10 elements
  - 0 : "stringValue"
  - 1 : "intValue"
  - 2 : "doubleValue"
  - 3 : "boolValue"
  - 4 : "objectValue"
  - 5 : "arrayValue1"
  - 6 : "arrayValue2"
  - 7 : "emptyArray"
  - 8 : "emptyObject"
  - 9 : "nullValue"
```

多层 key 使用`.`连接
比如`objectKey3`的子 key 顺序 ==》 path = "objectValue.objectKey3"

```swift
let multiPath = "objectValue.objectKey3"
let multiPathPathKeys = jsonObject.subKeysFor(keyPath: transformStringToArray(multiPath)) // ["key1","key2"]
```

## 获取 OrderJSON 的有序字典方法

```swift
    /// 获取 有序字典
    /// - Returns: 返回有序字典，如果 json 为数组则返回 nil
    public func orderedDictionary() -> OrderedDictionary<String, Any>?

    /// 获取 Any 类型， 其中 object 类型返回 `OrderedDictionary`
    /// - Returns: 返回 Any 类型。
    public func any() -> Any
```



参考文章

- [Swift 码了个 JSON 解析器(一)](https://oldbird.run/swift/fp/t3-json1.html)
- [Swift 码了个 JSON 解析器(二)](https://oldbird.run/swift/fp/t3-json2.html)
- [Swift 码了个 JSON 解析器(三)](https://oldbird.run/swift/fp/t3-json3.html)


目前仅支持 Swift Package Manager 集成
