//
//  AppDelegate.swift
//  iOS-Demo
//
//  Created by jeanboy on 2017/11/28.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: 初始化操作
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //状态栏样式
//        application.statusBarStyle = .lightContent
//        application.isStatusBarHidden = false
        
        initNetwork()//初始化网络配置
        initPurchase()//初始化内购
        initAnalysis(application, launchOptions: launchOptions)//初始化统计
        initHomeView()//初始化主页面
        return true
    }
}
extension AppDelegate {
    
    private func initNetwork(){
        NetManager.shareInstance.baseURLString = ApiConfig.BaseURL
    }
    
    private func initPurchase(){
        IAPManager.shareInstance.secret = IAPPurchaseInfo.secret
        IAPManager.shareInstance.completeTransaction()
    }
    
    private func initAnalysis(_ application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
        
//        AnalysisUtil.sharedInstance.logEnabled = AnalysisConfig.logEnabled  // 是否记录统计数据

//        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
//
//        Fabric.with([Crashlytics.self, Answers.self])
//
//        Flurry.startSession(ThirdPartyAnalysis.flurryKey)
//
//        AppsFlyerTracker.shared().appsFlyerDevKey = ThirdPartyAnalysis.appsFlyerID
//        AppsFlyerTracker.shared().appleAppID = ThirdPartyAnalysis.appleAppID
//
//        FirebaseApp.configure()
    }
    
    private func initHomeView(){
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController.init(rootViewController: homeViewController)
//        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

