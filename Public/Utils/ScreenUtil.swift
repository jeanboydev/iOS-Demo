//
//  ScreenUtil.swift
//  PhoneClear
//
//  Created by jeanboy on 2017/12/4.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import UIKit

//常见机型屏幕
let isIphone4:Bool = screenHeight  < 568
let isIphone5:Bool = screenHeight  == 568
let isIphone6:Bool = screenHeight  == 667
let isIphone6P:Bool = screenHeight == 736
let isIphoneX:Bool = screenHeight == 812

//非iPhone X ：StatusBar 高20px，NavigationBar 高44px，底部TabBar高49px
//iPhone X：StatusBar 高44px，NavigationBar 高44px，底部TabBar高83px

let headerSafeAreaHeight:CGFloat = UIApplication.shared.statusBarFrame.height
let footerSafeAreaHeight:CGFloat = isIphoneX ? 34 : 0
let headerBarHeight:CGFloat = 44
let footerBarHeight:CGFloat = 49

// navigationBarHeight
let navigationBarHeight:CGFloat =  headerSafeAreaHeight + headerBarHeight

// tabBarHeight
let tabBarHeight:CGFloat = footerSafeAreaHeight + footerBarHeight

//屏幕尺寸
let screenWidth:CGFloat = UIScreen.main.bounds.width
let screenHeight:CGFloat = UIScreen.main.bounds.height

//设计标准
let designWidth:CGFloat = 375
let desingHeight:CGFloat = 667

//缩放比例
var widthRatio:CGFloat = screenWidth / designWidth
var heightRatio:CGFloat = screenHeight / desingHeight

class ScreenUtil {
    
    class func getRelativeWidth(designSize:CGFloat) -> CGFloat! {
        return designSize * widthRatio
    }
    
    class func getRelativeHeight(designSize:CGFloat) -> CGFloat! {
        return designSize * heightRatio
    }
}
