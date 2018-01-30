//
//  AppInfo.swift
//
//  Created by jeanboy on 2018/1/11.
//  Copyright © 2018年 jeanboy. All rights reserved.
//

import Foundation
import UIKit

public struct AppInfo {

    /// bundle ID
    public static let bundleID = Bundle.main.bundleIdentifier!

    /// App显示名
    public static let displayName = Bundle.main.infoDictionary!["CFBundleDisplayName"] ?? ""

    /// 主版本号
    public static let versionName = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!

    /// build编号
    public static let versionCode = Bundle.main.infoDictionary!["CFBundleVersion"]!

}
