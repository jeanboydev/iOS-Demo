//
//  UIView+Extension.swift
//
//  Created by jeanboy on 2018/1/30.
//  Copyright © 2018年 jeanboy. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    /// 添加圆角
    ///
    /// - Parameters:
    ///   - roundingCorners: 圆角方向
    ///   - cornerSize: 圆角大小
    func addCorner(roundingCorners: UIRectCorner, cornerSize: CGSize) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerSize)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path.cgPath
        layer.mask = cornerLayer
    }
}
