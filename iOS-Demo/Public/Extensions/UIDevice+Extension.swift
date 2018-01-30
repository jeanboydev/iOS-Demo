//
//  UIDevice+Extension.swift
//
//  Created by jeanboy on 2018/1/30.
//  Copyright © 2018年 jeanboy. All rights reserved.
//

import Foundation
import UIKit

public extension UIDevice {
    
    /// 系统版本号，如：10.2.1
    public static let systemVersionCode = UIDevice.current.systemVersion
    
    /// 系统名称，如：iOS
    public static let systemCurrentName = UIDevice.current.systemName
    
    /// 设备udid
    public static let identifierNumber = UIDevice.current.identifierForVendor
    
    /// 当前语言
    public static let currentLanguage = NSLocale.preferredLanguages[0]
    
    /// 当前语言 identifier
    public static var currentLanguageIdentifier : String {
        let userDefault = UserDefaults.standard
        let languages:NSArray = userDefault.object(forKey: "AppleLanguages") as! NSArray
        return languages.object(at: 0) as! String
    }
    
    /// 当前语言编码
    public static let currentLanguageCode = NSLocale.current.languageCode!
    
    /// 当前设置的区域编码
    public static let currentRegionCode = NSLocale.current.regionCode!
    
    /// 是否已越狱
    public static let isJailbrokenState = UIDevice.current.isJailbroken
    
    /// 是否是iPhone
    public static let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    
    /// 是否是iPad
    public static let isPad = UIDevice.current.userInterfaceIdiom == .pad
    
    /// 设备型号，如：iPhone
    public static let modelType = UIDevice.current.model
    
    /// 设备区域化型号，如：A1533
    public static let modelLocalized = UIDevice.current.localizedModel
    
    /// 设备具体型号，如：iPhone 7 Plus
    public static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3":                              return "iPhoneX"
            
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
            
        case "AppleTV5,3":                              return "Apple TV"
            
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
