//
//  FolderUtil.swift
//
//  Created by jeanboy on 2017/12/15.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation

class FolderUtil {
    
    
    /// 获取沙盒中 Document 路径
    ///
    /// - Returns: Document/
    class func getDocumentURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL
    }
    
    /// 获取沙盒中 Document/xxx 的路径，没有自动创建
    ///
    /// - Parameter path: xxx
    /// - Returns: Document/xxx
    class func getDocumentURL(path: String) -> URL {
        var documentsURL = getDocumentURL()
        documentsURL.appendPathComponent(path, isDirectory: true)
        try! FileManager.default.createDirectory(atPath: documentsURL.path,
                                                 withIntermediateDirectories: true, attributes: nil)
        return documentsURL
    }
    
    
    /// 获取图片缓存URL
    ///
    /// - Parameter fileName:
    /// - Returns:
    class func getImageCacheURL(fileName: String) -> URL{
        var documentsURL = FolderUtil.getDocumentURL(path: AppFolder.cacheImages)
        documentsURL.appendPathComponent(fileName, isDirectory: false)
        return documentsURL
    }
    
    
    /// 删除缓存图片
    ///
    /// - Parameter fileName:
    class func removeImageCache(fileName: String){
        let fileManager = FileManager.default
        let cacheURL = FolderUtil.getImageCacheURL(fileName: fileName)
        try! fileManager.removeItem(at: cacheURL)
    }
}
