//
//  UIImage+Extension.swift
//
//  Created by jeanboy on 2018/1/2.
//  Copyright © 2018年 jeanboy. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {

    /// 从文件加载，不长驻内存， 适用于非Assets导入的图
    /// - Parameters:
    /// - name: 文件名
    /// - type: 文件扩展名
    convenience init?(named name: String, ofType type: String) {

        var filePath = Bundle.main.path(forResource: name, ofType: type)
        if nil == filePath {
            let name = name + ((3 == UIScreen.main.scale) ? "@3x" : "@2x")

            filePath = Bundle.main.path(forResource: name, ofType: type)
            if nil == filePath {
                return nil
            }
        }

        self.init(contentsOfFile: filePath!)
    }

    /// 根据文件名获取 saveToDocument() 保存的图片
    /// - fileName: 文件名
    convenience init?(fileName: String){
        let cacheURL = FolderUtil.getImageCacheURL(fileName: fileName)
        self.init(contentsOfFile: cacheURL.path)
    }
    
    /// 由当前图生成一个指定大小的图片
    ///
    /// - Parameter size: 指定大小
    /// - Returns: 生成的图片
    func resizeTo(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let toImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return toImage
    }
    
    /// 由当前图生成一个指定宽度大小的图片
    ///
    /// - Parameter maxWidth: 最大宽度
    /// - Returns: 生成的图片
    func scaleTo(maxWidth: CGFloat) -> UIImage {
        let aspect = self.size.height / self.size.width
        let resize = CGSize(width: maxWidth, height: maxWidth * aspect)
        return resizeTo(size: resize)
    }
    
    /// 由当前图生成一个指定高度大小的图片
    ///
    /// - Parameter maxHeight: 最大高度
    /// - Returns: 生成的图片
    func scaleTo(maxHeight: CGFloat) -> UIImage {
        let aspect = self.size.width / self.size.height
        let resize = CGSize(width: maxHeight * aspect, height: maxHeight)
        return resizeTo(size: resize)
    }

    /// 按比例缩放图片生成一个新的图
    ///
    /// - Parameter scale: 缩放比例 0.0 - 1.0
    /// - Returns: 缩放后的图
    func scaleTo(scale: CGFloat) -> UIImage {
        let toSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        return resizeTo(size: toSize)
    }
    
    
    /// 根据最大尺寸缩放图片
    ///
    /// - Parameter maxSize: 最大尺寸
    /// - Returns: 生成的图片
    func scaleTo(maxSize: CGFloat) -> UIImage {
        if self.size.width > self.size.height {
            let aspect = self.size.height / self.size.width
            let resize = CGSize(width: maxSize, height: maxSize * aspect)
            return resizeTo(size: resize)
        } else {
            let aspect = self.size.width / self.size.height
            let resize = CGSize(width: maxSize * aspect, height: maxSize)
            return resizeTo(size: resize)
        }
    }

    /// 将图片保存到沙盒 Document 中
    ///
    /// - Parameters:
    ///   - path: 路径
    ///   - fileName: 文件名
    func saveToDocument(path: String, fileName: String) {
        var documentsURL = FolderUtil.getDocumentURL(path: path)
        documentsURL.appendPathComponent(fileName, isDirectory: false)
        let saveData:Data = UIImageJPEGRepresentation(self, 100)!
        try! saveData.write(to: documentsURL)
    }
    
    /// 将图片保存到沙盒 Document/images 中，文件名为 123456789.jpg
    ///
    /// - Returns: 文件名
    func saveToDocument() -> String {
        let fileName = "\(Date().timeIntervalSince1970).jpg"
        saveToDocument(path: AppFolder.cacheImages, fileName: fileName)
        return fileName
    }
}
