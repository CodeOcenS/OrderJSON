//
//  OrderJSON.swift
//  
//
//  Created by Sven on 2021/4/20.
//

import Foundation
///// 有序josn
/////
///// - Warning: 此处有序并不代表实现了有序字典，只表示字典解析和 json 一致。
//public struct OrderJSON {
//    private var input: String
//    private var json: JSON?
//    public init(_ input: String) {
//        self.input = input
//        json = try? JsonParser.parse(text: input)
//    }
//    /// 是否为字典
//    public func isDictionary() -> Bool {
//        if let aJson = json, case .object(_) = aJson {
//            return true
//        } else {
//            return false
//        }
//    }
//    /// 是否为数组
//    public func isArray() -> Bool {
//        if let aJson = json, case .array(_) = aJson {
//            return true
//        } else {
//            return false
//        }
//    }
//    /// 返回字典 只有是字典
//    public func dictionary() -> [String: Any]? {
//        guard let result = json, case .object(_) = result  else {
//            return nil
//        }
//        let order = Order()
////        for temp in order.enumerated() {
////
////        }
//        let anyValue = result.any()
//        if let dic = (anyValue as? [String: Any]) {
//            return dic
//        }
//        return nil
//    }
//}

func test() -> Void {
    let order = OrderJSON()
    
    for (index, item) in order.enumerated() {
        
    }
    let dic: [String: Any] = [:]
    for (key, value) in dic.enumerated() {
        value
    }
}

struct OrderJSON: Sequence {
    typealias Element = Any
    var orderKeys: [String] = []
    var dictionary: [String: Any] = [:]
    
    func makeIterator() ->  OrderIterator {
        return OrderIterator(keys: orderKeys, dictionary: dictionary)
    }
    
    subscript(key:String) -> Any? {
        return dictionary[key]
    }
    
    
}

struct OrderIterator: IteratorProtocol {
    typealias Element = Any
    var keys: [String]
    var count: Int {
        keys.count
    }
    var currentIndex: Int = 0
    var dictionary: [String: Any]
    mutating func next() -> Element? {
        guard count != 0, currentIndex < count else {
            return nil
        }
        let key = keys[currentIndex]
        currentIndex += 1
        return dictionary[key]
    }
}
