//
//  UIColor+Extension.swift
//
//  Created by jeanboy on 2018/1/2.
//  Copyright © 2018年 jeanboy. All rights reserved.
//

import UIKit
import YYKit

public extension UIColor {

    /// 带透明度的16进制色值得到颜色
    /// - Parameters:
    ///   - hexString: 16进制色值
    ///   - alpha: 透明度 0-1.0
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        let alphaString = String(Int(alpha * 255), radix: 16)
        self.init(hexString: hexString + alphaString)
    }

    /// 使用RGB数值得到颜色
    ///
    /// - Parameters:
    ///   - r: 红 0-255.0
    ///   - g: 绿 0-255.0
    ///   - b: 蓝 0-255.0
    ///   - a: 透明度 0-1.0
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /// 判断颜色深浅
    ///
    /// - Returns: 是否是深颜色
    func isDark() -> Bool{
        let value = 0.299 * self.red + 0.587 * self.green + 0.114 * self.blue
        return value <= 0.75
    }
}
