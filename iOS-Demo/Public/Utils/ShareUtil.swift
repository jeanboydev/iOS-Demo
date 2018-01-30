//
//  ShareUtil.swift
//
//  Created by jeanboy on 2017/12/15.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import UIKit

class ShareUtil {
    
    
    /// 分享文件到第三方应用
    ///
    /// - Parameters:
    ///   - itemArray: 需要分享的文件URL
    ///   - controller:
    ///   - ipadView:
    class func toShare(itemArray: [URL], controller: UIViewController, ipadView: UIView){
        let activityController = UIActivityViewController.init(activityItems: itemArray, applicationActivities: nil)
        if !UIDevice.isPhone {
            let popover = activityController.popoverPresentationController
            popover?.sourceView = ipadView
            popover?.sourceRect = CGRect.init(x: 0, y: UIScreen.screenHeight, width: UIScreen.screenWidth, height: 100)
            popover?.permittedArrowDirections = UIPopoverArrowDirection.any
        }
        controller.present(activityController, animated: true, completion: nil)
    }
}
