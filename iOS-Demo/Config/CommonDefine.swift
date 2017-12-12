//
//  CommonDefine.swift
//  iOS-Demo
//
//  Created by jeanboy on 2017/12/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import UIKit
import YYKit

/*======================================Log============================================*/
//MARK:- DLog
func DLog<T>(_ message : T, file : String = #file, lineNumber : Int = #line) {
    
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        //    print("[\(fileName):line:\(lineNumber)]- \(message)")
        NSLog("[\(fileName):line:\(lineNumber)]- \(message)")
    #endif
}

/*======================================扩展UIImage============================================*/
//MARK:- 扩展UIImage
extension UIImage {
    
    // 从文件加载，不长驻内存， 适用于非Assets导入的图
    public convenience init?(named name: String, ofType type: String) {
        
        var filePath = Bundle.main.path(forResource: name, ofType: type)
        
        if nil == filePath {
            let name = name + ((3 == UIScreen.main.scale) ? "@3x" : "@2x")
            
            filePath = Bundle.main.path(forResource: name, ofType: type)
            if nil == filePath {
                return nil
            }
        }
        
        self.init(contentsOfFile: filePath!)
    }
}

/*======================================扩展UIColor============================================*/
//MARK:- 扩展UIColor
extension UIColor {
    
    // 16进制色值带透明度
    public convenience init?(hexString: String, alpha: CGFloat) {
        let alphaString = String(Int(alpha * 255), radix: 16)
        self.init(hexString: hexString + alphaString)
    }
    // 判断颜色深浅
    public func isDark() -> Bool{
        let value = 0.299 * self.red + 0.587 * self.green + 0.114 * self.blue
        return value <= 0.75
    }
}
/*======================================自定义字体============================================*/
//MARK:- 自定义字体
enum DesignFont {
    static let avenirBlack = "AvenirLTStd-Black"
}
/*======================================颜色============================================*/
//MARK:- color

// 用到的颜色
enum AppColor {
    
    static let navigationBar = "3f3f3f"
    static let navigationBarText = "ffffff"
}
