import XCTest
@testable import OrderJSON
@testable import OrderedCollections

final class OrderJSONTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(OrderJSON(), "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
    func testJSON2String() {
//        let json = OrderJSON([
//            "a": OrderJSON([OrderJSON(8), OrderJSON(-9), OrderJSON(+10)]),
//            "b": OrderJSON(10.2),
//            "c": OrderJSON(1),
//            "d": OrderJSON([
//                "name": OrderJSON("world"),
//                "say": OrderJSON("hello"),
//                "temp": OrderJSON(true),
//                "old": OrderJSON.null
//            ])
//        ])
//        XCTAssert(json)
    }
    
 
    // MARK: - json 解析 -> JSON
    
    /// 单层 json 解析
    
    func testSigleJson() {
        let json = "{\"temp\":true,\"say\":\"hello\",\"name\":\"world\"}"
        let jsonObj = try? JsonParser.parse(text: json)
        XCTAssertNotNil(jsonObj)
        
        let anyValue = jsonObj?.any()
        XCTAssertNotNil(anyValue)
        if let value = anyValue as? OrderedDictionary<String, Any> {
            let keys: OrderedSet<String> = ["temp", "say","name"]
            XCTAssertTrue(keys == value.keys)
        }
    }
    
    /// 多层 json 解析
    func testMutilayerJson() {
        let json = "{\"a\":[8,-9,+10],\"c\":{\"temp\":true,\"say\":\"hello\",\"name\":\"world\"},\"b\":10.2}"
        let jsonObj = try? JsonParser.parse(text: json)
        XCTAssertNotNil(jsonObj)
    }
    
    /// 包含空格 json 解析
    func testSpaceKeyJson() {
        let json = "{  \"a\":[8,-9,+10],\"c\":{\"temp\":true,\"say\":\"hello\",\"name\":\"world\"},   \"b\":10.2}"
        let jsonObj = try? JsonParser.parse(text: json)
        XCTAssertNotNil(jsonObj)
    }
    /// 空 json 解析
    func testEmtyJson() {
        let json = "{}"
        let jsonObj = try? JsonParser.parse(text: json)
        XCTAssertNotNil(jsonObj)
    }
    /// 含 空 json 和空数组解析
    func testEmtyValueJson() {
        let json = "{\"keyString\":\"字符串\",\"keyObjc\":{\"keyBool\":true},\"keyEmptyObjc\":{},\"keyArray\":[\"字符串1\",\"字符串2\"],\"keyEmptyArray\":[]}"
        let jsonObj = try? JsonParser.parse(text: json)
        XCTAssertNotNil(jsonObj)
    }
    
    /// 包含转义字符
//    func testContactEscapeJson() {
//        let escapeJson = """
//        """
//        let unicodeJson = """
//        {"unicode":"\u4e2d\u6587"}
//        """
//        let jsonObj = try? JsonParser.parse(text: unicodeJson)
//        XCTAssertNotNil(jsonObj)
//    }
    // MARK： - 解析转化为 字典
    
    private func transformOrderJSON() -> OrderJSON? {
        let json =
            """
        {"stringValue":"字符串","intValue":20,"doubleValue":12.8,"boolValue":false,"objectValue":{"objectKey1":"value1","objectKey2":2,"objectKey3":{"key":"value"}},"arrayValue1":[1,2,3],"arrayValue2":[{"name":"小明","age":18}],"emptyArray":[],"emptyObject":{},"nullValue":null}
        """
        return try? JsonParser.parse(text: json)
    }
    func testTransformYapiDataToJSON() {
        let jsonObj = transformOrderJSON()
        XCTAssertNotNil(jsonObj)
        
    }
    
    private func transformStringToArray(_ string: String) -> [String] {
        if string.isEmpty {
            return []
        }
        return string.components(separatedBy: ".")
    }
    
    /// 测试某路径下的 key 顺序
    func testJSONKeys() {
        guard let jsonObject = transformOrderJSON() else {
            XCTAssertFalse(false)
            return
        }
        let objectValuePath = "objectValue"
        let rootPath = ""
        let rootKeys = jsonObject.subKeysFor(keyPath: transformStringToArray(rootPath))
        XCTAssertTrue(rootKeys == ["stringValue","intValue","doubleValue","boolValue","objectValue","arrayValue1","arrayValue2","emptyArray","emptyObject","nullValue",])
        let dataKeysWhenRight = ["objectKey1", "objectKey2","objectKey3"]
        let dataKeys = jsonObject.subKeysFor(keyPath: transformStringToArray(objectValuePath))
        XCTAssertTrue(dataKeys == dataKeysWhenRight)
        
        let stringValuePath = "stringValue"
        let stringValueKeys = jsonObject.subKeysFor(keyPath: transformStringToArray(stringValuePath))
        XCTAssertTrue(stringValueKeys.isEmpty)
        
        let objectArrayValuePath = "arrayValue2"
        let objectValuePathKeys = jsonObject.subKeysFor(keyPath: transformStringToArray(objectArrayValuePath))
        XCTAssertTrue(objectValuePathKeys == ["name","age"])
        
        let multiPath = "objectValue.objectKey3"
        let multiPathPathKeys = jsonObject.subKeysFor(keyPath: transformStringToArray(multiPath))
        XCTAssertTrue(multiPathPathKeys == ["key"])
    }
    
    // MARK: - OrderedDictionary
    func testOrderedDictionary() {
        
    }
}
