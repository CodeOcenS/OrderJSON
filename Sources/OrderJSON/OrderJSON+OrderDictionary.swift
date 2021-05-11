//
//  File.swift
//  
//
//  Created by Sven on 2021/5/11.
//

import Foundation
import OrderedCollections

public extension OrderJSON {
    
    /// 获取 有序字典
    /// - Returns: 返回有序字典，如果 json 为数组则返回 nil
    func orderedDictionary() -> OrderedDictionary<String, Any>? {
        guard case .object(_) = self else {
            return nil
        }
        return (self.any() as! OrderedDictionary)
    }
    
    /// 获取 Any 类型， 其中 object 类型返回 `OrderedDictionary`
    /// - Returns: 返回 Any 类型。
    func any() -> Any {
        switch self {
        case .array(let values):
            return values.map{ $0.any() }
        case .object(let keyValues):
            var dic:OrderedDictionary<String, Any> = [:]
            keyValues.forEach { object in
                if let firstKey = object.keys.first, let anyValue = object[firstKey]?.any  {
                    dic[firstKey] = anyValue
                }
            }
            return dic
        case .string(let value):
            return value
        case .double(let value):
            return value
        case .int(let value):
            return value
        case .bool(let value):
            return value
        case .null:
            return NSNull()
        }
    }
}
