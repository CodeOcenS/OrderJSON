//
//  OrderJSON.swift
//  
//
//  Created by Sven on 2021/4/20.
//

import Foundation
/// 有序josn
///
/// - Warning: 此处有序并不代表实现了有序字典，只表示字典解析和 json 一致。
struct OrderJSON {
    private var input: String
    private var json: JSON?
    init(_ input: String) {
        self.input = input
        json = try? JsonParser.parse(text: input)
    }
    /// 是否为字典
    func isDictionary() -> Bool {
        if let aJson = json, case .object(_) = aJson {
            return true
        } else {
            return false
        }
    }
    /// 是否为数组
    func isArray() -> Bool {
        if let aJson = json, case .array(_) = aJson {
            return true
        } else {
            return false
        }
    }
    /// 返回字典 只有是字典
    func dictionary() -> [String: Any]? {
        guard let result = json, case .object(_) = result  else {
            return nil
        }
    
        let anyValue = result.any()
        if let dic = (anyValue as? [String: Any]) {
            return dic
        }
        return nil
    }
}
