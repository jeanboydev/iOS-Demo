//
//  PermissionTool.swift
//  
//
//  Created by jeanboy on 2018/2/5.
//  Copyright © 2018年 jeanboy. All rights reserved.
//

import Foundation
import UIKit
import Photos
import Contacts

enum AuthType: String {
    case Camera = "Camera"
    case PhotoLibrary = "Photo Library"
    case Contacts = "Contacts"
}

class PermissionTool {
    
    /// 检查权限
    ///
    /// - Parameters:
    ///   - controller: controller
    ///   - authType: 权限类型
    ///   - onSuccess: 成功回调
    public class func check(controller: UIViewController, authType: AuthType, onSuccess:@escaping () -> ()) {
        
        switch authType {
        case AuthType.Camera:
            checkCamera(onSuccess: onSuccess, onError: {
                showNoPermission(controller: controller, authType: authType)
            })
        case AuthType.PhotoLibrary:
            checkPhotoLibrary(onSuccess: onSuccess, onError: {
                showNoPermission(controller: controller, authType: authType)
            })
        case AuthType.Contacts:
            checkPhotoLibrary(onSuccess: onSuccess, onError: {
                showNoPermission(controller: controller, authType: authType)
            })
        default: break
        }
    }
    
    /// 检查相机权限
    ///
    /// - Parameters:
    ///   - onSuccess: onSuccess
    ///   - onError: onError
    private class func checkCamera(onSuccess:@escaping () -> (), onError:@escaping () -> ()){
        let auth = AVCaptureDevice.authorizationStatus(for: .video)
        
        if auth == .authorized {
            onSuccess()
            return
        }
        
        if auth == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (result) in
                DispatchQueue.main.async {
                    if result {
                        onSuccess()
                    } else {
                        onError()
                    }
                }
            })
        } else {
            onError()
        }
    }
    
    /// 检查图库权限
    ///
    /// - Parameters:
    ///   - onSuccess: onSuccess
    ///   - onError: onError
    private class func checkPhotoLibrary(onSuccess:@escaping () -> (), onError:@escaping () -> ()){
        let auth = PHPhotoLibrary.authorizationStatus()
        
        if auth == .authorized {
            onSuccess()
            return
        }
        
        if auth == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (result) in
                DispatchQueue.main.async {
                    switch(result) {
                    case .authorized:
                        onSuccess()
                    default:
                        onError()
                        break
                    }
                }
            }
        } else {
            onError()
        }
    }
    
    /// 检查联系人权限
    ///
    /// - Parameters:
    ///   - onSuccess: onSuccess
    ///   - onError: onError
    private class func checkContacts(onSuccess:@escaping () -> (), onError:@escaping () -> ()){
        let auth = CNContactStore.authorizationStatus(for: .contacts)
        
        if auth == .authorized {
            onSuccess()
            return
        }
        
        if auth == .notDetermined {
            CNContactStore().requestAccess(for: .contacts, completionHandler: { (result, error) in
                DispatchQueue.main.async {
                    if result {
                        onSuccess()
                    } else {
                        onError()
                    }
                }
            })
        } else {
            onError()
        }
    }
    
    /// 显示未授权弹窗，提示去设置权限
    ///
    /// - Parameters:
    ///   - controller: controller
    ///   - authType: 授权类型
    private class func showNoPermission(controller: UIViewController, authType: AuthType){
        let alertController = UIAlertController(title: "Permission for \(authType.rawValue) was denied",
            message: "Please enable access to \(authType.rawValue) in the Settings app.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel, handler:nil)
        let settingsAction = UIAlertAction(title:"Settings", style: .default, handler: {
            (action) -> Void in
            let url = URL(string: UIApplicationOpenSettingsURLString)
            if let url = url, UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: {
                        (success) in
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
}

