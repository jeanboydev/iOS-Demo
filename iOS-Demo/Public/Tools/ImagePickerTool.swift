//
//  ImagePickerHelper.swift
//
//  Created by jeanboy on 2017/12/25.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerTool {
    
    class func presentImagePicker(controller: UIViewController, delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate, sourceView: UIView) {
        let imagePickerActionSheet = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        //相机拍照
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take photo", style: .default) { (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = delegate
                imagePicker.sourceType = .camera
                controller.present(imagePicker, animated: true)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        //图库选择
        let libraryButton = UIAlertAction(title: "Select from Gallary", style: .default) { (alert) -> Void in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = delegate
            imagePicker.sourceType = .photoLibrary
            controller.present(imagePicker, animated: true)
        }
        imagePickerActionSheet.addAction(libraryButton)
        //取消按钮
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        
        // support iPad
        if let popoverController = imagePickerActionSheet.popoverPresentationController {
            popoverController.sourceView = sourceView
            popoverController.sourceRect = sourceView.bounds
        }
        
        //打开弹窗
        controller.present(imagePickerActionSheet, animated: true)
    }
}
