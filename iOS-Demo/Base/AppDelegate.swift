//
//  AppDelegate.swift
//
//  Created by jeanboy on 2017/11/28.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyUserDefaults
import FacebookCore
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: 初始化操作
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //状态栏样式
//        application.statusBarStyle = .lightContent
//        application.isStatusBarHidden = false
        
        initDataBase()//初始化数据库配置
        initNetwork()//初始化网络配置
        initPurchase()//初始化内购
        initAnalysis(application, launchOptions: launchOptions)//初始化统计
        initHomeView()//初始化主页面
        return true
    }
}
extension AppDelegate {
    
    /// 初始化数据库配置
    private func initDataBase(){
        DataBaseManager.shared.setup()
    }
    
    /// 初始化网络配置
    private func initNetwork(){
        NetManager.shareInstance.baseURLString = ApiConfig.BaseURL
    }
    
    /// 初始化内购
    private func initPurchase(){
        IAPManager.shareInstance.secret = IAPPurchaseInfo.secret
        IAPManager.shareInstance.completeTransaction()
    }
    
    /// 初始化统计
    ///
    /// - Parameters:
    ///   - application:
    ///   - launchOptions:
    private func initAnalysis(_ application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
        
//        AnalysisTool.shared.appsFlyerEnabled = false
//        AnalysisTool.shared.firebaseEnabled = false
//        AnalysisTool.shared.flurryEnabled = false
//        AnalysisTool.shared.fbNormalEventEnabled = false
//        AnalysisTool.shared.fbSystemEventEnabled = true
//        AnalysisTool.shared.setup(withApplication: application, withLaunchOptions: launchOptions, flurryKey: AnalysisConfig.flurryKey, appsFlyerKey: AnalysisConfig.appsFlyerID, appleAppID: AnalysisConfig.appleAppID, logEnabled: AnalysisConfig.logEnabled)
    }
    
    /// 初始化主页面
    private func initHomeView(){
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let launchViewController = LaunchViewController()
        let navigationController = UINavigationController.init(rootViewController: launchViewController)
//        let homeViewController = HomeViewController()
//        let navigationController = UINavigationController.init(rootViewController: homeViewController)
//        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

