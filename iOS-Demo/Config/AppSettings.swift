//
//  AppSettings.swift
//
//  Created by jeanboy on 2017/11/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
  
  /// 是否已通过审核
  static let reviewPassed = DefaultsKey<Bool>("reviewPassed")
  
  /// 是否VIP
  static let isVIP = DefaultsKey<Bool>("isVIP")
  
  /// 订阅过期时间
  static let subscriptionExprireDate = DefaultsKey<TimeInterval>("subscriptionExprireDate")
  
  /// 周订阅价格
  static let oneWeekSubscriptionPrice = DefaultsKey<String>("oneWeekSubscriptionPrice")
  
}

