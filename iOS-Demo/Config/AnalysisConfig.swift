//
//  AnalysisSettings.swift
//
//  Created by jeanboy on 2017/12/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation

/*======================================事件统计============================================*/
enum AnalysisConfig {
    
    static let facebookID = "****************"
    static let flurryKey = "*******************"
    static let appsFlyerID = "****************"
    static let appleAppID = "****************"
    
    /// 设置 debug 时是否开启事件统计
    #if DEBUG
    static let logEnabled = true
    #else
    static let logEnabled = true
    #endif
}
