//
//  PurchaseSettings.swift
//
//  Created by jeanboy on 2017/12/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation

/*======================================内购============================================*/
struct IAPPurchaseInfo {
    
    /// 产品ID
    enum ProductID {
        static let oneWeek = "com.uas.cleaner.oneWeek"
    }
    
    /// 验证密钥
    static let secret = "****************************"
    
    /// 默认显示价格
    static let defaultPrice = "$49.99"
    
    /// 默认显示App名称
    static let appName = AppInfo.displayName
}
