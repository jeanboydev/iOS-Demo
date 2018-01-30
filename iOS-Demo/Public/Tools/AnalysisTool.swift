//
//  AnalysisUtil.swift
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

class AnalysisTool {
    
    /// 是否记录facebook普通事件, facebook内购事件一直打开
    public var fbNormalEventEnabled = true
    
    /// 是否记录facebook自动统计事件
    public var fbSystemEventEnabled = true
    
    /// 是否记录appsFlyer事件
    public var appsFlyerEnabled = true
    
    /// 是否记录flurry事件
    public var flurryEnabled = true
    
    /// 是否记录firebase事件
    public var firebaseEnabled = true
    
    /// 是否记录统计事件
    private var logEnabled = true
    
    
    static let shared = AnalysisTool()
    private init() {}
    
    func setup(withApplication application: UIApplication,
               withLaunchOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?,
               flurryKey: String, appsFlyerKey: String, appleAppID: String, logEnabled: Bool){
       
        guard logEnabled else { return }
        self.logEnabled = logEnabled
        
        #if DEBUG
            Crashlytics.sharedInstance().debugMode = true
            Fabric.sharedSDK().debug = true
        #endif
        
        if fbSystemEventEnabled{
            AppEventsLogger.activate()
        }
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        Fabric.with([Crashlytics.self, Answers.self])
        
        if flurryEnabled {
            Flurry.startSession(flurryKey)
        }
        
        if appsFlyerEnabled {
            AppsFlyerTracker.shared().appsFlyerDevKey = appsFlyerKey
            AppsFlyerTracker.shared().appleAppID = appleAppID
        }
        
        if firebaseEnabled {
            FirebaseApp.configure()
        }
        
        // 打开进入前台事件监听
        NotificationCenter.default.addObserver(self, selector:#selector(applicationDidBecomeActive(notification:)),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    /// 记录事件
    ///
    /// - Parameters:
    ///   - event: 事件名称
    public func logEvent(event: String)  {
        
        guard logEnabled else { return }
        
        if fbNormalEventEnabled {
            AppEventsLogger.log(event)
        }
        
        if flurryEnabled {
            Flurry.logEvent(event)
        }
        
        if appsFlyerEnabled {
            AppsFlyerTracker.shared().trackEvent(event, withValues: nil)
        }
        
        // fabric事件
        Answers.logCustomEvent(withName: event, customAttributes: nil)
    }

    /// 记录事件
    ///
    /// - Parameters:
    ///   - event: 事件名称
    ///   - parameters: 事件参数
    public func logEventWithParameters(event: String, parameters: Dictionary<String, Any>) {
        
        guard logEnabled else { return }
        
        if fbNormalEventEnabled {
            AppEventsLogger.log(event)
        }
        
        if flurryEnabled {
            Flurry.logEvent(event, withParameters: parameters)
        }
        
        if appsFlyerEnabled {
            AppsFlyerTracker.shared().trackEvent(event, withValues: parameters)
        }
        
        // fabric事件
        Answers.logCustomEvent(withName: event, customAttributes: parameters)
    }

    /// 记录内购事件
    ///
    /// - Parameters:
    ///   - price: 价格
    ///   - currency: 币种
    ///   - identifier: 商品ID
    ///   - name: 商品名
    ///   - description: 商品描述
    public func logIAPEvent(price: Double, currency: String, identifier: String, name: String, description: String) {
        
        guard logEnabled else { return }
        
        logPurchaseEvent(price: price, currency: currency, identifier: identifier, name: name, description: description)
    }
    
}

// MARK:- event response methos
private extension AnalysisTool {
    
    /// 追踪APP打开
    ///
    /// - Parameters:
    ///   - notification: 通知详情
    @objc private func applicationDidBecomeActive(notification: NSNotification) -> Void {
        
        guard logEnabled else { return }
        
        if fbNormalEventEnabled {
            if let application = (notification.object as? UIApplication) {
                AppEventsLogger.activate(application)
            }
        }
        
        if appsFlyerEnabled {
            AppsFlyerTracker.shared().trackAppLaunch()
        }
    }
    
}

// MARK:- private methos
private extension AnalysisTool {
    
    /// 记录内购事件
    private func logPurchaseEvent(price: Double, currency: String, identifier: String, name: String, description: String) {
        let allName = "purchase_in_app_all"
        let singleName = "purchase_" + identifier.replacingOccurrences(of: ".", with: "_")
        let priceString = String.init(format: "%.2f", price)
        let identifier = identifier.replacingOccurrences(of: ".", with: "_")
        
        // fabric
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
        
        // Facebook
        let fbparams : AppEvent.ParametersDictionary = [
            .currency : currency ,
            .contentType : description ,
            .contentId : identifier]
        
        let allEvent = AppEvent(name: allName, parameters: fbparams, valueToSum: price)
        let singleEvent = AppEvent(name: singleName, parameters: fbparams, valueToSum: price)
        
        AppEventsLogger.log(.purchased(amount: price, currency: currency, extraParameters: fbparams))
        AppEventsLogger.log(allEvent)
        AppEventsLogger.log(singleEvent)
        
        if appsFlyerEnabled {
            // appsFlyer
            let ASDic = [AFEventParamRevenue: priceString ,
                         AFEventParamCurrency: currency ,
                         AFEventParamContentType: description ,
                         AFEventParamContentId: identifier]
            
            AppsFlyerTracker.shared().trackEvent(allName, withValues: ASDic)
            AppsFlyerTracker.shared().trackEvent(singleName, withValues: ASDic)
        }
        
        if firebaseEnabled {
            // FireBase
            let fireBaseDic = [AnalyticsParameterValue: NSNumber.init(value: price),
                               AnalyticsParameterCurrency: currency as NSObject ,
                               AnalyticsParameterItemName: description as NSObject ,
                               AnalyticsParameterItemID: identifier as NSObject]
            
            Analytics.logEvent(allName, parameters: fireBaseDic)
            Analytics.logEvent(singleName, parameters: fireBaseDic)
        }
    }
    
}
