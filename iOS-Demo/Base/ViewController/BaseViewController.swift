//
//  BaseViewController.swift
//
//  Created by jeanboy on 2017/11/8.
//  Copyright © 2017年 jeanboy. All rights reserved.
//
import UIKit
import SnapKit
import WebKit
import SwiftyUserDefaults

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
   
    
    var isHadLeftButton: Bool = true
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubViews()
    }
    
    /// 解决自定义 leftBarButtonItem 时，返回手势失效
    ///
    /// - Parameter animated: 
    override func viewDidAppear(_ animated: Bool) {
        if isHadLeftButton {
            self.navigationController?.interactivePopGestureRecognizer!.delegate = self
            //解决自定义 leftBarButtonItem 并使用 webView 时，返回手势失效
            if webView != nil {
                let tap = UISwipeGestureRecognizer(target:self, action:nil)
                tap.delegate = self
                self.webView?.addGestureRecognizer(tap)
            }
        }
    }
    
    /// 解决自定义 leftBarButtonItem 时，返回手势失效，webView 手势处理
    ///
    /// - Parameters:
    ///   - gestureRecognizer:
    ///   - otherGestureRecognizer:
    /// - Returns:
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        return true
    }
    
    /// 解决自定义 leftBarButtonItem 时，返回手势失效，手势处理
    ///
    /// - Parameter gestureRecognizer:
    /// - Returns:
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return self.navigationController!.viewControllers.count > 1
        }
        return true
    }
    
    //MARK:- 状态栏白色(全局修改)
//    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    
    //MARK:- 状态栏白色(局部修改)
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return UIColor.init(hexString: navigationBarColor)!.isDark() ? .lightContent : .default
//    }
    
    /// 状态栏白色(局部修改)
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    /// 自定义返回按钮点击响应
    func doBack(){
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// 自定义关闭按钮响应
    func doClose(){
        dismiss(animated: true, completion: nil)
    }
    
    /// 初始化 View
    func initSubViews(){
        
        //隐藏系统导航栏，使用自定义导航栏
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.backgroundColor = UIColor.init(hexString: AppColor.background)
    }
    
    /// 延迟操作
    ///
    /// - Parameters:
    ///   - delayTime: 延迟时间 秒
    ///   - onAction: 执行操作
    func delayAction(delayTime: TimeInterval, onAction: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayTime) {
            onAction()
        }
    }
}
