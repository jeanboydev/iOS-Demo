//
//  IAPManager.swift
//  FotoableProject
//
//  Created by jeanboy on 2017/11/6.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import SwiftyStoreKit
import StoreKit

typealias PurchaseCompletion = (_ result: IAPPurchaseResult) -> Void
typealias RestoreCompletion = (_ result: IAPRestoreResult) -> Void
typealias VerifyCompletion = (_ result: IAPVerifyResult) -> Void

// purchase结果
enum IAPPurchaseResult {
    case success(product: SKProduct, expireDate: Date)
    case canceled
    case purchaseFail
    case verifyFail(product: SKProduct)
}

// restore结果
enum IAPRestoreResult {
    case success(expireDate: Date)
    case expired
    case fail
    case nothing
}

// verify结果
enum IAPVerifyResult {
    case success(expireDate: Date)
    case expired
    case notPurchased
    case netError
    case fail
}

class IAPManager: NSObject {
    
    var secret:String = ""     // 验证密钥
    
    static let shareInstance = IAPManager()
    private override init() {}
}

extension IAPManager  {
    
    /**
     结束未完成的购买，每次启动时要在didFinishLaunchingWithOptions里调用
     */
    func completeTransaction() {
        
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                if purchase.transaction.transactionState == .purchased || purchase.transaction.transactionState == .restored {
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                }
            }
        }
    }
    
    /**
     根据商品ID得到商品信息
     
     @param productIDs 商品ID
     */
    func retriveProductsInfo(productIDs: Set<String>) {
        SwiftyStoreKit.retrieveProductsInfo(productIDs) { result in
        }
    }
    
    /**
     购买商品
     
     @param productID 商品ID
     @param completion 购买结束后的回调
     */
    func purchaseAutoRenewable(productID: String, completion: @escaping PurchaseCompletion) {
        
        SwiftyStoreKit.purchaseProduct(productID, atomically: true) { [weak self] result in
            
            if case .success(let purchase) = result {
                // Deliver content from server, then:
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                
                self?.verifyAutoRenewable(productID: productID, completion: { (result) in
                    switch result {
                    case .success(let expireDate):
                        completion(IAPPurchaseResult.success(product: purchase.product, expireDate: expireDate))
                    case .expired:
                        completion(IAPPurchaseResult.purchaseFail)
                    case .notPurchased:
                        completion(IAPPurchaseResult.purchaseFail)
                    default:
                        completion(IAPPurchaseResult.verifyFail(product: purchase.product))
                    }
                })
            } else  {
                if case .error(let error) = result {
                    DLog(error)
                    switch error.code {
                    case .paymentCancelled:
                        completion(IAPPurchaseResult.canceled)
                    default:
                        completion(IAPPurchaseResult.purchaseFail)
                    }
                } else {
                    completion(IAPPurchaseResult.purchaseFail)
                }
            }
        }
    }
    
    /**
     恢复商品
     
     @param productID 商品ID
     @param completion 恢复结束后的回调
     */
    func restore(productID: String, completion: @escaping RestoreCompletion) {
        SwiftyStoreKit.restorePurchases(atomically: true) { [weak self] results in
            if results.restoreFailedPurchases.count > 0 {
                completion(IAPRestoreResult.fail)
            } else if results.restoredPurchases.count > 0 {
                
                self?.verifyAutoRenewable(productID: productID, completion: { (result) in
                    switch result {
                    case .success(let expireDate):
                        completion(IAPRestoreResult.success(expireDate: expireDate))
                    case .expired:
                        completion(IAPRestoreResult.expired)
                    default:
                        completion(IAPRestoreResult.fail)
                    }
                })
            } else {
                completion(IAPRestoreResult.nothing)
            }
        }
    }
    
    /**
     验证票据
     
     @param productID 商品ID
     @param completion 验证结束后的回调
     */
    func verifyAutoRenewable(productID: String, completion: @escaping VerifyCompletion) {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: self.secret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            
            switch result {
            case .success(let receipt):
                let purchaseResult = SwiftyStoreKit.verifySubscription(
                    type: .autoRenewable,
                    productId: productID,
                    inReceipt: receipt)
                
                switch purchaseResult {
                case .purchased(let expireDate, _):
                    completion(IAPVerifyResult.success(expireDate: expireDate))
                case .expired(_, _):
                    completion(IAPVerifyResult.expired)
                case .notPurchased:
                    completion(IAPVerifyResult.notPurchased)
                }
            case .error(let error):
                
                switch error {
                case .networkError(_):
                    completion(IAPVerifyResult.netError)
                default:
                    completion(IAPVerifyResult.fail)
                }
            }
        }
    }
    
}
