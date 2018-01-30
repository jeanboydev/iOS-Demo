//
//  ApiSettings.swift
//
//  Created by jeanboy on 2017/12/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation

/*======================================接口============================================*/
struct ApiConfig {
    
    /// 接口版本号, 每次上线需检查是否修改
    static let VersionCode = AppInfo.versionCode
    
    /// 网络请求地址
    #if DEBUG
    static let BaseURL = "http://www.baidu.com"
    #else
    static let BaseURL = "http://www.baidu.com"
    #endif
    
    /// API
    static let APISettings  = "/public/setting"    // 获取settings
}

/*======================================结束状态码============================================*/
enum FinishCode: Int {
    case success = 200
    case fail = 10000
}
