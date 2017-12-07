//
//  AnalysisUtil.swift
//  iOS-Demo
//
//  Created by jeanboy on 2017/12/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import Fabric
import Crashlytics
import AppsFlyerLib
import FirebaseAnalytics
import FacebookCore
import Flurry_iOS_SDK

class AnalysisUtil {
    
    var logEnabled = true
    
    static let sharedInstance = AnalysisUtil()
    private init() {}
    
    func logEvent(event: String)  {
        if logEnabled {
            Flurry.logEvent(event)
            Answers.logCustomEvent(withName: event, customAttributes: nil)
            AppsFlyerTracker.shared().trackEvent(event, withValues: nil)
            AppEventsLogger.log(event)
        }
    }
    
    func logEventWithParameters(event: String, parameters: Dictionary<String, Any>) {
        if logEnabled {
            Flurry.logEvent(event, withParameters: parameters)
            Answers.logCustomEvent(withName: event, customAttributes: parameters)
            AppsFlyerTracker.shared().trackEvent(event, withValues: parameters)
            AppEventsLogger.log(event)
        }
    }
    
    func logIAPEvent(price: Double, currency: String, identifier: String, name: String, description: String) {
        
        if logEnabled {
            logPurchaseEvent(price: price, currency: currency, identifier: identifier, name: name, description: description)
        }
    }
    
    private func logPurchaseEvent(price: Double, currency: String, identifier: String, name: String, description: String) {
        let allName = "purchase_in_app_all"
        let singleName = "purchase_" + identifier.replacingOccurrences(of: ".", with: "_")
        let priceString = String.init(format: "%.2f", price)
        let identifier = identifier.replacingOccurrences(of: ".", with: "_")
        
        //fabric
        let paraDic = ["price" : priceString,
                       "currency" : currency,
                       "productName" : description,
                       "productId" : identifier] as [String : Any]
        
        Answers.logCustomEvent(withName: allName, customAttributes: paraDic)
        Answers.logCustomEvent(withName: singleName, customAttributes: paraDic)
        Answers.logPurchase(withPrice: NSDecimalNumber(value: price),
                            currency: currency,
                            success: true,
                            itemName: name,
                            itemType: description,
                            itemId: identifier,
                            customAttributes: [:])
        
        //AS
        let ASDic = [AFEventParamRevenue: priceString ,
                     AFEventParamCurrency: currency ,
                     AFEventParamContentType: description ,
                     AFEventParamContentId: identifier]
        
        AppsFlyerTracker.shared().trackEvent(allName, withValues: ASDic)
        AppsFlyerTracker.shared().trackEvent(singleName, withValues: ASDic)
        
        //Facebook
        let fbparams : AppEvent.ParametersDictionary = [
            .currency : currency ,
            .contentType : description ,
            .contentId : identifier]
        
        let allEvent = AppEvent(name: allName, parameters: fbparams, valueToSum: price)
        let singleEvent = AppEvent(name: singleName, parameters: fbparams, valueToSum: price)
        
        AppEventsLogger.log(.purchased(amount: price, currency: currency, extraParameters: fbparams))
        AppEventsLogger.log(allEvent)
        AppEventsLogger.log(singleEvent)
        
        //FireBase
        let fireBaseDic = [AnalyticsParameterValue: NSNumber.init(value: price),
                           AnalyticsParameterCurrency: currency as NSObject ,
                           AnalyticsParameterItemName: description as NSObject ,
                           AnalyticsParameterItemID: identifier as NSObject]
        
        Analytics.logEvent(allName, parameters: fireBaseDic)
        Analytics.logEvent(singleName, parameters: fireBaseDic)
    }
    
}
