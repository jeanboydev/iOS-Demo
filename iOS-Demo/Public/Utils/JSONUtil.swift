//
//  JsonUtil.swift
//
//  Created by jeanboy on 2017/11/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation

class JSONUtil {
    
    
    /// 对象转Json
    ///
    /// - Parameter obj: 对象类型
    /// - Returns:
    class func toJson<T: Codable>(_ obj: T) -> String {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(obj)
        let str = String(data: data, encoding: String.Encoding.utf8)
        return str!
    }
    
    
    /// Json转对象
    ///
    /// - Parameters:
    ///   - type: 对象类型
    ///   - data: json数据
    /// - Returns:
    class func toObject<T: Codable>(_ type: T.Type, _ data: String) -> T {
        let decoder = JSONDecoder()
        let obj = try! decoder.decode(type, from: data.data(using: String.Encoding.utf8)!)
        return obj
    }
}
