//
//  LaunchViewModel.swift
//
//  Created by jeanboy on 2017/11/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class SubscriptionViewModel {
    
    private var resultCount = 0
    private var successCount = 0
    
    /// 与服务器同步状态
    ///
    /// - Parameter completion: <#completion description#>
    func syncWithServer(completion: @escaping (_ code: FinishCode) -> Void) {
        
        if Defaults[.isVIP] {
            // 当前是VIP状态， 需验证VIP有效性
            if Defaults[.subscriptionExprireDate] < Date().timeIntervalSince1970 {
                // 根据本地时间判断已过期, restore
                debugPrint("restore...")
                IAPManager.shareInstance.restore(productID: IAPPurchaseInfo.ProductID.oneWeek, completion: { [weak self] (result) in
                    self?.resultCount += 1
                    self?.successCount += 1
                    
                    switch result {
                    case .success(let expireDate):
                        debugPrint("restore success, expireDate=\(expireDate)")
                        Defaults[.isVIP] = true
                        Defaults[.subscriptionExprireDate] = expireDate.timeIntervalSince1970
                        break
                    default:
                        debugPrint("restore fail")
                        Defaults[.isVIP] = false
                    }
                    
                    if 2 == self?.resultCount {
                        completion(2 == self?.successCount ? FinishCode.success : FinishCode.fail)
                    }
                })
                
            } else {
                // 根据本地时间判断未过期
                resultCount = 1
                successCount = 1
            }
        } else {
            // 非VIP,不用验证
            resultCount = 1
            successCount = 1
        }
        
        getSettingsFromServer {[weak self] code in
            self?.resultCount += 1
            if FinishCode.success == code {
                self?.successCount += 1
            } else {
                // 获取失败
            }
            
            if 2 == self?.resultCount {
                completion(2 == self?.successCount ? FinishCode.success : FinishCode.fail)
            }
        }
    }
    
    
    /// 获取settings
    ///
    /// - Parameter completion:
    func getSettingsFromServer(completion: @escaping (_ code: FinishCode) -> Void) {
        
        let parameters = ["versionCode": ApiConfig.VersionCode, "packageName": Bundle.main.bundleIdentifier!];
        
        NetManager.shareInstance.get(urlString: ApiConfig.APISettings, parameters: parameters) { (responseData, error) in
            
            guard nil == error else {
                completion(FinishCode.fail)
                return
            }
            
            guard let responseDictionary = (responseData as? NSDictionary) else {
                completion(FinishCode.fail)
                return
            }
            
            guard let dataDictionary = (responseDictionary["data"] as? NSDictionary) else {
                completion(FinishCode.fail)
                return
            }
            
            if let price = (dataDictionary["price"] as? String) {
                Defaults[.oneWeekSubscriptionPrice] = price
            }
            
            if let isOpen = (dataDictionary["isOpen"] as? Bool) {
                Defaults[.reviewPassed] = isOpen
            }
            
            completion(FinishCode.success)
        }
    }
    
}
