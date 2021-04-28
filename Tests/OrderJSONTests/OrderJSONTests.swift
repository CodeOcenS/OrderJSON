import XCTest
@testable import OrderJSON

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
    // MARK： - 解析转化为 字典
    let yapiJSON =
        """
    {"type":"object","title":"empty object","properties":{"data":{"type":"object","properties":{"stringValue":{"type":"string","description":"字符串类型","mock":{"mock":"字符串"}},"integerValue":{"type":"integer","description":"整型数据类型","mock":{"mock":"20"}},"numberValue":{"type":"number","description":"浮点数据类型","mock":{"mock":"15.5"}},"booleanValue":{"type":"boolean","description":"布尔类型","mock":{"mock":"true"}},"arrayValue":{"type":"array","items":{"type":"string","mock":{"mock":"数组字符串"}},"description":"数组类型"}},"required":["stringValue","integerValue","numberValue","booleanValue","arrayValue"]},"code":{"type":"string","mock":{"mock":"200"}}},"required":["data","code"]}
    """
    private func transformYapiData() -> OrderJSON? {
        try? JsonParser.parse(text: yapiJSON)
    }
    func testTransformYapiDataToJSON() {
        let jsonObj = transformYapiData()
        XCTAssertNotNil(jsonObj)
        
    }
    
//    func testJSONAnyVale() {
//        guard let jsonObj = transformYapiData() else {
//            return
//        }
//        let anyValue = jsonObj.any()
//        guard let dic = anyValue as? [String: Any] else {
//            XCTAssertTrue(true, "通过YApij son字符串创建的JSON对象， 扩展 any() 方法返回值转字必须成功")
//            return
//        }
//
//        XCTAssertTrue(dic["type"] as! String == "object")
//        XCTAssertTrue(dic["required"] as! [String] == ["data","code"])
//    }

}
