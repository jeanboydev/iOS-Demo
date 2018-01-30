//
//  UIScreen+Extension.swift
//
//  Created by jeanboy on 2018/1/30.
//  Copyright © 2018年 jeanboy. All rights reserved.
//

import Foundation
import UIKit

public extension UIScreen {
    
    /// 屏幕宽度
    public static let screenWidth = UIScreen.main.bounds.width
    
    /// 屏幕高度
    public static let screenHeight = UIScreen.main.bounds.height
    
    /// 当前scale
    public static let screenScale = UIScreen.main.scale
    
    /// 非iPhone X ：StatusBar 高20px，NavigationBar 高44px，底部TabBar高49px
    /// iPhone X：StatusBar 高44px，NavigationBar 高44px，底部TabBar高83px
    /// 头部安全区域
    public static let headerSafeAreaHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    
    /// 底部安全区域
    public static let footerSafeAreaHeight: CGFloat = isIphoneX ? 34.0 : 0.0
    
    /// 状态栏高度
    public static let navigationBarHeight: CGFloat = 44.0
    
    /// TabBar高度
    public static let tabBarHeight: CGFloat = 49.0
    
    /// 头部安全区+状态栏
    public static let headerWithBarHeight: CGFloat = headerSafeAreaHeight + navigationBarHeight
    
    /// 底部安全区+TabBar
    public static let footerWithBarHeight: CGFloat = footerSafeAreaHeight + tabBarHeight
    
    /// 是否3.5寸屏
    public static let isInch35 = (320 == screenWidth && 480 == screenHeight)
    
    /// 是否4.0寸屏
    public static let isInch40 = (320 == screenWidth && 568 == screenHeight)
    
    /// 是否4.7寸屏
    public static let isInch47 = (375 == screenWidth && 667 == screenHeight)
    
    /// 是否5.5寸屏
    public static let isInch55 = (414 == screenWidth && 736 == screenHeight)
    
    /// 是否5.8寸屏
    public static let isInch58 = (375 == screenWidth && 812 == screenHeight)
    
    /// 是否iPhone5s或更小的设备
    public static let isIphone5sOrSmall = 568 >= screenHeight
    
    /// 是否iPhone6或同等屏幕设备
    public static let isIphoneNormal = isInch47
    
    /// 是否iPhone6 Pluse或同等屏幕设备
    public static let isIphonePlus = isInch55
    
    /// 是否iPhoneX
    public static let isIphoneX = isInch58
    
    /*---------------------------设计适配------------------------------------------*/
    
    /// 设计标准屏幕宽度
    public static let designWidth: CGFloat = 375
    
    /// 设计标准屏幕高度
    public static let desingHeight: CGFloat = 667
    
    /// 屏幕宽度缩放比例
    public static let widthRatio: CGFloat = screenWidth / designWidth
    
    /// 屏幕高度缩放比例
    public static let heightRatio: CGFloat = screenHeight / desingHeight
    
    class func getRelativeWidth(designSize:CGFloat) -> CGFloat! {
        return designSize * widthRatio
    }
    
    class func getRelativeHeight(designSize:CGFloat) -> CGFloat! {
        return designSize * heightRatio
    }
    
    class func getRelativeSize(designSize:CGFloat) -> CGFloat! {
        return designSize * widthRatio
    }
}
