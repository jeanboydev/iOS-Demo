//
//  DateUtil.swift
//  EasyScanner
//
//  Created by jeanboy on 2017/12/20.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import UIKit

class DateUtil {
    
    static let weekday = "EEEE"//表示星期几(Monday),使用1-3个字母表示周几的缩写
    static let month = "MMMM"//月份的全写(October),使用1-3个字母表示月份的缩写
    static let day = "dd"//表示日期,使用一个字母表示没有前导0
    static let year = "yyyy"//四个数字的年份  YYYY:当前是2017-12-31  结果返回的是2018  yyyy:当前返回的年份正确
    static let hour = "HH"//两个数字表示的小时
    static let minute = "mm"//两个数字的分钟
    static let second = "ss"//两个数字的秒
    static let zone = "zzz"//三个字母表示的时区
    
    //项目需求自定义
    static let formatterDate = ""//2017年12月20日，使用dateStyle = .medium本地化处理
    static let formatterMonth = "MMMM"//12月
    static let formatterMonthNum = "M"//数字月份
    static let formatterDay = "dd"//20日
    static let formatterTime = "HH:mm"//14.26
    static let formatterSecond = "ss"//01
    static let formatterAMPM = "GGG"//AM PM
    
    
    /// 获取当前日期
    ///
    /// - Returns: 当前日期
    class func getCurrentDate() -> Date {
        let currentDate = Date()
        return currentDate
    }
    
    
    /// 格式化日期本地化
    ///
    /// - Parameter date:
    /// - Returns:
    class func formatLocalMedium(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: UIDevice.currentLanguageIdentifier)
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    /// 格式化日期
    ///
    /// - Parameters:
    ///   - date: date
    ///   - formatter: formatter
    /// - Returns: 日期
    class func format(date: Date, formatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: UIDevice.currentLanguageIdentifier)
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: date)
    }
    
    /// String 格式化为日期
    ///
    /// - Parameters:
    ///   - dateString: dateString
    ///   - formatter: formatter
    /// - Returns: 日期
    class func format(dateString: String, formatter: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: UIDevice.currentLanguageIdentifier)
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from: dateString)
    }
    
    /// 时间戳转日期
    ///
    /// - Parameter timestamp: 时间戳
    /// - Returns: 日期
    class func format(timestamp: Double) -> Date {
        let timeInterval = TimeInterval(exactly: timestamp)
        return Date(timeIntervalSince1970: timeInterval!)
    }
}

extension Date {
    
    func timestamp() -> Double {
        return self.timeIntervalSince1970
    }
}
